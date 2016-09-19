
#Getting and Cleaning Data Course Projectless 
#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
#The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on 
#a series of yes/no questions related to the project. You will be required to submit: 
#1) a tidy data set as described below, 
#2) a link to a Github repository with your script for performing the analysis, and 
#3) a code book that describes the variables, the data, and any transformations or work that you performed 
#to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
#This repo explains how all of the scripts work and how they are connected.
#One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
#Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
#The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
#A full description is available at the site where the data was obtained:
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#Here are the data for the project:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#You should create one R script called run_analysis.R that does the following.
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#Source data are loaded and stored localy from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Download the file and put the file in the data folder
setwd("C:/Dobs")

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
Unzip the file

unzip(zipfile="./data/Dataset.zip",exdir="./data/UCI HAR Dataset")
featuresNames <- read.table("./Data/UCI HAR Dataset/features.txt",header=FALSE)
head(featuresNames)
#  V1                V2
#1  1 tBodyAcc-mean()-X
#2  2 tBodyAcc-mean()-Y
#3  3 tBodyAcc-mean()-Z
#4  4  tBodyAcc-std()-X
#5  5  tBodyAcc-std()-Y
#6  6  tBodyAcc-std()-Z

# Extract only the data on mean and standard dev
featuresSelRec <- grep(".*mean.*|.*std.*", featuresNames[,2])
# Load train datasets
trainSubjectSet <- read.table("./Data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
trainActivitySet <- read.table("./Data/UCI HAR Dataset/train/Y_train.txt",header=FALSE)
trainSet <- read.table("./Data/UCI HAR Dataset/train/X_train.txt",header=FALSE)[featuresSelRec]
trainData <- cbind(trainSubjectSet, trainActivitySet, trainSet)

# Load test datasets
testSubjectSet <- read.table("./Data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
testActivitySet <- read.table("./Data/UCI HAR Dataset/test/Y_test.txt",header=FALSE)
testSet <- read.table("./Data/UCI HAR Dataset/test/X_test.txt",header=FALSE)[featuresSelRec]
testData <- cbind(testSubjectSet, testActivitySet, testSet)

# Create a full data set
FullData <- rbind(trainData, testData)
# Assign proper labels
featuresSelRec.names <- featuresNames[featuresSelRec,2];
featuresSelRec.names = gsub("^t", "time", featuresSelRec.names);
featuresSelRec.names = gsub("^f", "frequency", featuresSelRec.names);
featuresSelRec.names = gsub("Acc", "Accelerometer", featuresSelRec.names);
featuresSelRec.names = gsub("Gyro", "Gyroscope", featuresSelRec.names);
featuresSelRec.names = gsub("Mag", "Magnitude", featuresSelRec.names);
featuresSelRec.names = gsub("BodyBody", "Body", featuresSelRec.names);
featuresSelRec.names = gsub('-mean', 'Mean', featuresSelRec.names);
featuresSelRec.names = gsub('-std', 'Std', featuresSelRec.names);
featuresSelRec.names <- gsub('[-()]', '', featuresSelRec.names);
# Assign labels to Full Data Set
colnames(FullData) <- c("subject_id", "activity_id", featuresSelRec.names);

# Generate tidyData data set.  

tidyData = aggregate(FullData[,names(FullData) != c('activity_id','subject_id')],by=list(activity_id=FullData$activity_id,subject_id 
+                                                                                          = FullData$subject_id),mean);
write.table(tidyData, "C:/Users/Una/DSCleaningData/tidyData.txt",row.names=TRUE,sep='\t');