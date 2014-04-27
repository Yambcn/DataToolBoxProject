## Getting and Cleaning data Project
## Get data from text files
trainingX<-read.table("X_train.txt")
trainingY<-read.table("Y_train.txt")
trainingS<-read.table("subject_train.txt")
TableTraining<-data.frame(trainingX,trainingY,trainingS)
testX<-read.table("X_test.txt")
testY<-read.table("Y_test.txt")
testS<-read.table("subject_test.txt")
TableTest<-data.frame(testX,testY,testS)
## Same number of variables different number of observations
## Exercice 1: merging data
mergedData=rbind(TableTraining,TableTest)
## Exercice 2: Obtain the measurements from the mean and standard deviations variables
meanColumns<-grep("mean()", features$V2)
meanMeasurements<-mergedData[,meanColumns]
STDColumns<-grep("std()", features$V2)
STDMeasurements<-mergedData[,STDColumns]
Exercice2=data.frame(meanMeasurements,sdMeasurements)
##Exercice 3: Add the name of the Activities at the big Data Frame
## Chosen Method: By subbsetting the 6 different activities
mergedData$V1.1[mergedData$V1.1 == 1] <- "1. WALKING"
mergedData$V1.1[mergedData$V1.1 == 2] <- "2. WALKING_UPSTAIRS"
mergedData$V1.1[mergedData$V1.1 == 3] <- "3. WALKING_DOWNSTAIRS"
mergedData$V1.1[mergedData$V1.1 == 4] <- "4. SITTING"
mergedData$V1.1[mergedData$V1.1 == 5] <- "5. STANDING"
mergedData$V1.1[mergedData$V1.1 == 6] <- "6. LAYING"
##Exercice 4: Label the table based on the name activity
## Ordering the table based on the assigned number to each activity
Exercice4<-mergedData[order(mergedData$V1.1),]
## Exercice 5: Creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject
library(reshape2)
tinydata= melt(mergedData, id = c("V1.1","V1.2"))
tinyDATA<-dcast(tinydata, V1.1 + V1.2 ~ variable,mean) 
write.table(tinyDATA, file="./tidydata.txt", sep="\t")