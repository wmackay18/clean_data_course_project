# Download data

library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
        download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
        unzip("UCI HAR Dataset.zip", exdir = getwd())
}

# Read & convert to data frame

features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])
X_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_activity <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
train_subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')
train_data <-  data.frame(train_subject, train_activity, X_train)
names(train_data) <- c(c('subject', 'activity'), features)
X_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
test_subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')
test_data <-  data.frame(test_subject, test_activity, X_test)
names(test_data) <- c(c('subject', 'activity'), features)

# Merge training and tesing

merged_data <- rbind(train_data, test_data)

# Get mean and standard dev

mean_std_dev <- grep('mean|std', features)
temp_data <- merged_data[,c(1,2,mean_std_dev + 2)]

# Name activities

act_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
act_labels <- as.character(act_labels[,2])
temp_data$activity <- act_labels[temp_data$activity]

# Label data set

new_label <- names(temp_data)
new_label <- gsub("[(][)]", "", new_label)
new_label <- gsub("^t", "TimeDomain_", new_label)
new_label <- gsub("^f", "FrequencyDomain_", new_label)
new_label <- gsub("Acc", "Accelerometer", new_label)
new_label <- gsub("Gyro", "Gyroscope", new_label)
new_label <- gsub("Mag", "Magnitude", new_label)
new_label <- gsub("-mean-", "_Mean_", new_label)
new_label <- gsub("-std-", "_StandardDeviation_", new_label)
new_label <- gsub("-", "_", new_label)
names(temp_data) <- new_label

# Generate new data set

tidy_data <- aggregate(temp_data[,3:81], by = list(activity = temp_data$activity, subject = temp_data$subject),FUN = mean)
write.table(x = tidy_data, file = "tidy_data.txt", row.names = FALSE)

head(tidy_data)
