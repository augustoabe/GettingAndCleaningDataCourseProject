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
joint$actions <- rbind(labelsTest, labelsTrain)

subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
joint$subject <- rbind(subjectTest, subjectTrain)

tidyData <- data.frame()
len <- length(names(joint))-2
for( i in 1:30 ){
        for( j in 1:6 ){
                df <- filter( joint, actions == j & subject == i )
                df1 <- data.frame( subject = c(i), actions = c(j) )
                for( k in 1:len ){
                        df[,k] <- as.numeric(df[,k])
                        df1[,features[k]] <- mean(df[,k])
                }
                tidyData <- rbind(tidyData, df1)
        }
}
actlabels <- read.table("UCI HAR Dataset/activity_labels.txt")
actlabels[,1] <- as.character(actlabels[,1])
tidyData[,2] <- as.character(tidyData[,2])
for( i in 1:6 ){
        tidyData[,2] <- sub( actlabels[i,1], actlabels[i,2], tidyData[,2] )
}
