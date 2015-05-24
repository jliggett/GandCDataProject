library(data.table)
library(dplyr)

featNames <- read.table("./data/UCI HAR Dataset/features.txt")
activityLab <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)

subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

colnames(features) <- t(featNames[2])

colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
data <- cbind(features,activity,subject)

meanSTD <- grep(".*Mean.*|.*Std.*", names(data), ignore.case=TRUE)

columns <- c(meanSTD, 562, 563)
dim(data)

extracted <- data[,columns]

extracted$Activity <- as.character(extracted$Activity)

for(i in 1:6) {
        extracted$Activity[extracted$Activity == i] <- as.character(activityLab[i,2])
}

extracted$Activity <- as.factor(extracted$Activity)
names(extracted)

names(extracted)<-gsub("Acc", "Accelerometer", names(extracted))
names(extracted)<-gsub("Gyro", "Gyroscope", names(extracted))
names(extracted)<-gsub("BodyBody", "Body", names(extracted))
names(extracted)<-gsub("Mag", "Magnitude", names(extracted))
names(extracted)<-gsub("^t", "Time", names(extracted))
names(extracted)<-gsub("^f", "Frequency", names(extracted))
names(extracted)<-gsub("tBody", "TimeBody", names(extracted))
names(extracted)<-gsub("-mean()", "Mean", names(extracted), ignore.case = TRUE)
names(extracted)<-gsub("-std()", "STD", names(extracted), ignore.case = TRUE)
names(extracted)<-gsub("-freq()", "Frequency", names(extracted), ignore.case = TRUE)
names(extracted)<-gsub("angle", "Angle", names(extracted))
names(extracted)<-gsub("gravity", "Gravity", names(extracted))

extracted$Subject <- as.factor(extracted$Subject)

extracted <- data.table(extracted)

tidy <- aggregate(. ~Subject + Activity, extracted, mean)
tidy <- tidy[order(tidy$Subject,tidy$Activity),]

write.table(tidy, file = "tidy.txt", row.names = FALSE)
