# Loading the data and unzipping it

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- "dataset.zip"
download.file(URL, destFile)
unzip(destFile)

# Reading the data

setwd("./UCI HAR Dataset")

y_testset <- read.table("./test/y_test.txt", header = FALSE)
y_trainset <- read.table("./train/y_train.txt", header = FALSE)

x_testset <- read.table("./test/X_test.txt", header = FALSE)
x_trainset <- read.table("./train/X_train.txt", header = FALSE)

subject_testset <- read.table("./test/subject_test.txt", header = FALSE)
subject_trainset <- read.table("./train/subject_train.txt", header = FALSE)

activity_labels <- read.table("activity_labels.txt", header = FALSE)
features <- read.table("features.txt", header = FALSE)

# Merging the test datasets with train data

y_Data <- rbind(y_testset, y_trainset)
x_Data <- rbind(x_testset, x_trainset)
subject_Data <- rbind(subject_testset, subject_trainset)

# Renaming the columns in activity data

names(y_Data) <- "ActivityN"
names(activity_labels) <- c("ActivityN", "Activity")

# Making a factor of the activity names

Activity <- left_join(y_Data, activity_labels, by = "ActivityN")[, 2]

# Renaming the columns in subject data

names(subject_Data) <- "Subject"

#Renaming the columns in feature data

names(x_Data) <- features$V2

# Merging the data to a large dataset

dataset1 <- cbind(subject_Data, Activity, x_Data)

# Create new dataset with only the measurements on the mean and standard deviation for each measurement

subfeatures <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
datasetnames <- c("Subject", "Activity", as.character(subfeatures))
dataset2 <- subset(dataset1, select=datasetnames)

# Naming the columns appropriately

names(dataset2) <- gsub("^t", "time", names(dataset2))
names(dataset2) <- gsub("^f", "frequency", names(dataset2))
names(dataset2) <- gsub("Acc", "Accelerometer", names(dataset2))
names(dataset2) <- gsub("Gyro", "Gyroscope", names(dataset2))
names(dataset2) <- gsub("Mag", "Magnitude", names(dataset2))
names(dataset2) <- gsub("BodyBody", "Body", names(dataset2))

# Creating another dataset with the average of each variable for each activity and each subject

dataset3 <- aggregate(. ~Subject + Activity, dataset2, mean)

# Saving the final dataset
write.table(dataset3, "tidydataset.txt", row.name=FALSE)
