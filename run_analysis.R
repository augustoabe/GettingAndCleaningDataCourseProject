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
        classLabels[,1] <- sub( actlabels[i,1], actlabels[i,2], classLabels[,1] )
}
joint$actions <- classLabels

walk <- filter( joint, actions == "WALKING" )
walkup <- filter( joint, actions == "WALKING_UPSTAIRS" )
walkdown <- filter( joint, actions == "WALKING_DOWNSTAIRS" )
sit <- filter( joint, actions == "SITTING" )
stand <- filter( joint, actions == "STANDING" )
lay <- filter( joint, actions == "LAYING" )

mwalk <- c()
mwalkup <- c()
mwalkdown <- c()
msit <- c()
mstand <- c()
mlay <- c()

for( i in 1:ncol(walk) ){
        mwalk <- c( mwalk, mean( walk[,i] ) )
        mwalkup <- c( mwalkup, mean( walkup[,i] ) )
        mwalkdown <- c( mwalkdown, mean( walkdown[,i] ) )
        msit <- c( msit, mean( sit[,i] ) )
        mstand <- c( mstand, mean( stand[,i] ) )
        mlay <- c( mlay, mean( lay[,i] ) )
}

tidyData <- data.frame(row.names = c("WALKING", "WALKING_UPSTAIRS", 
                                     "WALKING_DOWNSTAIRS", "SITTING",
                                     "STANDING", "LAYING"))

for( i in 1:length(features) ){
        tidyData[,features[i]] <- c(mwalk[i], mwalkup[i], mwalkdown[i], 
                                    msit[i], mstand[i], mlay[i])
}





