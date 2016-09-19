setwd("C:/Dobs");
featuresNames <- read.table("./Data/UCI HAR Dataset/features.txt",header=FALSE);
# Extract only the data on mean and standard dev
featuresSelRec <- grep(".*mean.*|.*std.*", featuresNames[,2]);
# Load train datasets
trainSubjectSet <- read.table("./Data/UCI HAR Dataset/train/subject_train.txt",header=FALSE);
trainActivitySet <- read.table("./Data/UCI HAR Dataset/train/Y_train.txt",header=FALSE);
trainSet <- read.table("./Data/UCI HAR Dataset/train/X_train.txt",header=FALSE)[featuresSelRec];
trainData <- cbind(trainSubjectSet, trainActivitySet, trainSet);

# Load test datasets
testSubjectSet <- read.table("./Data/UCI HAR Dataset/test/subject_test.txt",header=FALSE);
testActivitySet <- read.table("./Data/UCI HAR Dataset/test/Y_test.txt",header=FALSE);
testSet <- read.table("./Data/UCI HAR Dataset/test/X_test.txt",header=FALSE)[featuresSelRec];
testData <- cbind(testSubjectSet, testActivitySet, testSet);

# Create a full data set
FullData <- rbind(trainData, testData);
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

tidyData = aggregate(FullData[,names(FullData) != c('activity_id','subject_id')],by=list(activity_id=FullData$activity_id,subject_id = FullData$subject_id),mean);
write.table(tidyData, "C:/Users/Una/DSCleaningData/tidyData.txt",row.names=TRUE,sep='\t');
