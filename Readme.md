##Introduction
This script is designed to perform the tasks listed in the Getting and Cleaning Data Course Project.

##Initalisation
Before the tassks can be completed there is preparatory work is performed.

The working directory is set:C:/Users/User/OneDrive/Getting and Cleaning Data/Data/Course Project/Data Project

Required libraries are loaded: library(downloader) ; library(data.table) ;library(plyr)

compressed data is downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data Book is located at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data is downloaded and then decompressed and results in a number of text files:X_train.txt ; y_train.txt; subject_train.txt ; X_test.txt ;
y_test.txt; subject_test.txt.

The data is now in a form to be read into datatables and processed.


##Step 1
 Merge the training and test sets to create one data set called subject_data



##Step 2 
Extracts the means and standard deviations from the features dataframe for each measurement using the grep() function.  
The names of the columns are changed 


##Step 3
This reads features.txt file into a dataframe called fetures. Column names are then changed to names descriptive 
of activity. 


##Step 4
Labels the data set with descriptive variable names using the names() function

## Step 5
This step creates an independent tidy data set, called averages_data with the average of each variable for each activity and each subject from the all_data dataframe.


##
The dataframe averages_data is written to a csv file called avearges_data.txt



