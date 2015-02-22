library(downloader)
library(plyr)

# 1. Download data
FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
FileName <- "./data/Dataset.zip"

if (!(file.exists("./data"))){
        dir.create("./data")
}

if(!file.exists(FileName)){
        download(FileUrl, dest=FileName, mode="wb") 
        unzip (FileName, exdir = "./data")
}

xtest<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
names(xtest)<- 
ytest<-read.table("./data/UCI HAR Dataset/test/Y_test.txt")
subjecttest<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")

xtrain<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
ytrain<-read.table("./data/UCI HAR Dataset/train/Y_train.txt")
subjecttrain<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Get activity labels 
activitylabels<-read.table("./data/UCI HAR Dataset/activity_labels.txt",
                          col.names = c("Id", "Activity"))
#Get features labels
featurelabels<-read.table("./data/UCI HAR Dataset/features.txt",
                        colClasses = c("character"))

# Create names for data set from the feature labels
names(xtest)<- featurelabels$V2
names(xtrain)<- featurelabels$V2
names(subjecttrain) <- "Subject"
names(subjecttest) <- "Subject"
names(ytest) <- "Labels"
names(ytrain) <- "Labels"

traindata<-cbind(cbind(xtrain, subjecttrain), ytrain)
testdata<-cbind(cbind(xtest, subjecttest), ytest)

# 2. Merges the training and the test sets to create one data set.
alldat<- rbind(testdata,traindata)

# 3. Extracts only the measurements on the mean and standard deviation for each measurement.

alldat <- alldat[,grepl("mean\\(\\)|std\\(\\)|Subject|Labels", names(alldat))]

# 4. Uses descriptive activity names to name the activities in the data set
alldat$Activity <- activitylabels$Activity[match(alldat$Labels,activitylabels$Id )]

# 5. Appropriately labels the data set with descriptive names.  
# (Mostly done in lines 34-39 above. Here I remove brackets to improve readability)

names(alldat) <- gsub("([()])","",names(alldat))

# 6. From the data set in step 4, creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject

tidydat <- ddply(alldat, c("Subject","Activity"), numcolwise(mean))

# Write tidy data set to file
write.table(tidydat, "./tidydat.txt", row.names=FALSE, sep=",")

#Write codebook
codebook <- capture.output(cat(names(tidydat),sep="\n"))
write.table(codebook,"./codebook.txt", col.names=FALSE)
