# Code Book

This document describes the script `run_anlaysis.R`.

The code is segemented by the following comments:

- Download data
- Read & convert to data frame
- Merge training and testing
- Get mean and standard dev
- Name activities
- Label data set
- Generate new data set

## Download data

Downloads and unzips Human Activity Recognition Using Smartphones Data Set 

```
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
        download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
        unzip("UCI HAR Dataset.zip", exdir = getwd())
}
```

## Read & convert to data frame

- `features` var stores `features.txt` data as chars. 
- `X_train` stores `X_train.txt` data.
- `train_activity` stores `y_train.txt` data.
- `train_subject` stores `subject_train.txt` data.
- `train_data` is a data frame of `train_subject`, `train_activity`, & `X_train`. 
- `X_test` stores `X_test.txt` data.
- `test_activity` stores `test_activity.txt` data.
- `test_subject` stores `test_subject.txt` data.
- `train_data` is a data frame of `test_subject`, `test_activity`, & `X_test`. 

## Merge training and testing

Bind `train_data` and `test_data` into one data set: `merged_data`.

## Get mean and standard dev

 - Search for matches to pattern 'mean|std' in `features` variable and store result in `mean_std_dev`.
 - Get only the mean and standard deviation from `merged_data` and store in `temp_data`.

## Name activities

Read file `activity_labels.txt` and store in varaible `act_labels`. Substitutes the activity names for the activity IDs.

## Label data set

Adds labels to `temp_data`.

```
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
```

## Generate new data set

Using the `aggregate` function, part fo the script takes the average of each variable for each activity and each subject and stores the result a new data frame called `tidy_data`. 

```
tidy_data <- aggregate(temp_data[,3:81], by = list(activity = temp_data$activity, subject = temp_data$subject),FUN = mean)
write.table(x = tidy_data, file = "tidy_data.txt", row.names = FALSE)
```
