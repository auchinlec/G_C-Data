#Load libraries to be used during project and set working directory
library(downloader)
library(data.table)
library(plyr)

setwd("C:/Users/User/OneDrive/Getting and Cleaning Data/Data/Course Project/Data Project")

###########################################################################


#Project Objectives:

#You should create one R script called run_analysis.R that does 
#the following.

# 1. Merges the training and the test sets to create one data set.

# 2. Extracts only the measurements on the mean and standard 
#    deviation for each measurement. 

# 3. Uses descriptive activity names to name the activities in the data set

# 4. Appropriately labels the data set with descriptive variable names. 

# 5. From the data set in step 4, creates a second, independent
#    tidy data set with the average of each variable for each 
#    activity and each subject.

#############################################################################
#Preparation
# Read data book located at # Data Book - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

############################################################################

#Download, unzip and store data in 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "

download.file(url, dest="dataset.zip", mode="wb") #Download zipfile to workinjg direcrory

#Decompress the file using unzip and store files in df
df <- unzip ("dataset.zip", exdir = "./Data Project")
#############################################################################
# Step 1 - Merge the training and test sets to create one data set

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

x_data <- rbind(x_train, x_test) # create 'x' data set

y_data <- rbind(y_train, y_test) # create 'y' data set

subject_data <- rbind(subject_train, subject_test) # create 'subject' data set
###############################################################################
#Step 2 Extract only the measurements on the mean and stddev for each measurement

features <- read.table("./UCI HAR Dataset/features.txt")

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_data <- x_data[, mean_and_std_features]

# correct the column names
names(x_data) <- features[mean_and_std_features, 2]

#################################################################################
#Step 3 - Use descriptive activity names to name the activities in the data set 

features <- read.table("./UCI HAR Dataset/features.txt") # Read features.txt into data.frame

mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2]) # mean and std columns

x_data <- x_data[, mean_and_std_features] # subset the desired columns

names(x_data) <- features[mean_and_std_features, 2] # change column names

activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

##################################################################################
#Step 4 - Appropriately label the data set with descriptive variable names

names(subject_data) <- "subject" # correct column name

all_data <- cbind(x_data, y_data, subject_data) # bind all the data in a single data set

#################################################################################
# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
# Step 5. From the data set in step 4, creates a second, independent
#    tidy data set with the average of each variable for each 
#    activity and each subject.


# Calculate column means for all cols except activity & subject
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

##################################################################################

#Write result to txt file

write.table(averages_data, "./UCI HAR Dataset/averages_data.txt", row.name=FALSE)
