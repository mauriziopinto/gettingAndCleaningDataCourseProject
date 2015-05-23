##############################################################
# ==========================================
# Getting and Cleaning Data - Course Project
# ==========================================
##############################################################
# The purpose of this project is to demonstrate your ability 
# to collect, work with, and clean a data set.
# 
# The script does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard 
#    deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the
#    data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy 
#    data set with the average of each variable for each activity
#    and each subject.
##############################################################

library(data.table)
library(reshape2)

dataFolder <- "data"
# Check if the directory the will contain the file exists
if(!file.exists(dataFolder)) {
        # create the folder
        dir.create(dataFolder)
}

# Assign the fileName to load
fileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
zipFile <- file.path(dataFolder, fileName, fsep=.Platform$file.sep)

# Assign the url of the zipped file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Check if the file has been already downloaded previously
if(!file.exists(zipFile)) {
        download.file(fileUrl, zipFile)
}

# Unzip the file
unzip(zipFile, overwrite=TRUE, exdir=dataFolder)

# The test and train dataset have three files each:
# 1. y_???.txt - the activity the subject is performing (walking, sitting, etc)
# 2. subject_???.txt - the subject ID
# 3. X_???.txt A vector of 561 measurements

# Load the activity labels
activityLabels <- read.table(
        file.path(dataFolder, "UCI HAR Dataset", "activity_labels.txt"),
        header=FALSE, 
        col.names=c("activity_id", "activity_name"))

activityLabels$activity_name <- as.factor(activityLabels$activity_name)

# Load the features labels
featuresLabels <- read.table(
        file.path(dataFolder, "UCI HAR Dataset", "features.txt"),
        header=FALSE,
        col.names=c("feature_id", "feature_name"))

# Load the test dataset
test.subject <- read.table(
        file.path(dataFolder, "UCI HAR Dataset", "test", "subject_test.txt"),
        header=FALSE,
        col.names=c("subject"))

test.x <- read.table(
        file.path(dataFolder, "UCI HAR Dataset", "test", "X_test.txt"),
        header=FALSE,
        col.names=featuresLabels$feature_name)

test.y <- read.table(
        file.path(dataFolder, "UCI HAR Dataset", "test", "y_test.txt"),
        header=FALSE,
        col.names=c("activity_id"))

# Load the train dataset
train.subject <- read.table(
        file.path(dataFolder, "UCI HAR Dataset", "train", "subject_train.txt"),
        header=FALSE,
        col.names=c("subject"))

train.x <- read.table(
        file.path(dataFolder, "UCI HAR Dataset", "train", "X_train.txt"),
        header=FALSE,
        col.names=featuresLabels$feature_name)

train.y <- read.table(
        file.path(dataFolder, "UCI HAR Dataset", "train", "y_train.txt"),
        header=FALSE,
        col.names=c("activity_id"))

# Use human-readable labels for the activities
test.y <- merge(test.y, activityLabels)
train.y <- merge(train.y, activityLabels)

# Remove the unnecessary columns (the ones that do not contain Mean or Std in the name)
test.x <- test.x[, grep("mean|std", names(test.x))]
train.x <- train.x[, grep("mean|std", names(train.x))]

# Finally combine the datasets
data <- rbind(cbind(test.subject, test.y, test.x) ,cbind(train.subject, train.y, train.x))

# Remove the numeric activity_id column
data[, 2] <- NULL

# Improve the names of the variables
names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))

# Compute the means, grouped by subject/label
melted <- melt(data, id.var = c("subject", "activity_name"))
means <- dcast(melted , subject + activity_name ~ variable, mean)

# Write the tidy dataset to the filesystem
write.table(means, file=file.path(dataFolder, "tidy_data.txt"))




