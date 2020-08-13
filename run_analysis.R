library(dplyr)
testSet <- read.table("UCI HAR Dataset/test/X_test.txt")
trainSet <- read.table("UCI HAR Dataset/train/X_train.txt")
joint <- rbind(testSet, trainSet)
features <- read.table("UCI HAR Dataset/features.txt")
indexMean <- grep("mean[()]", features[,2])
indexStd <- grep("std[()]", features[,2])
index <- sort(c(indexMean, indexStd))
joint <- joint[,index]
features <- features[index,2]

labelsTest <- read.table("UCI HAR Dataset/test/y_test.txt")
labelsTrain <- read.table("UCI HAR Dataset/train/y_train.txt") 
classLabels <- rbind(labelsTest, labelsTrain)
classLabels[,1] <- as.character(classLabels[,1])

actlabels <- read.table("UCI HAR Dataset/activity_labels.txt")
actlabels[,1] <- as.character(actlabels[,1])
for( i in 1:6 ){
        sub( actlabels[i,1], actlabels[i,2], classLabels[,1] )
}






