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

- Read file `activity_labels.txt` and store in varaible `act_labels`.

## Label data set


## Generate new data set


