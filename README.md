# Getting And Cleaning Data Peer Assessment

## Description of Data
This repo contains my solution to the Peer Assessment for the subject Getting and Cleaning Data.

The data for this assignment represent data collected from the accelerometers from the Samsung Galaxy S smartphone.  The original data can be found at the following url:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The version of the data used was found at the course website:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script run_analysis.R downloads the data and processes it into a tidy data set, containing  average of each variable for each activity and each subject. Specifically it 

1. Downloads the data from the course website into the /data folder

2. Merges the training and the test sets to create one data set.

3. Extracts only the measurements on the mean and standard deviation for each measurement. 

4. Uses descriptive activity names to name the activities in the data set

5. Appropriately labels the data set with descriptive variable names. 

6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Tidy data and Codebook files

The tidy data set is tidydat.txt.

Codebook.md contains a description of tidydat.txt.  

