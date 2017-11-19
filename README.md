# The Getting and Cleaning Data Course Project from Coursera

The purpose of this project is to demonstrate the ability to collect, work with, and clean a dataset. The goal is to prepare tidy data that can be used for later analysis. 

## About the Data Source

[Original Data Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

[Original Description of the Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## About the Dataset

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## About the Attribute Information

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## About the Transformation

1. Merges the training and the test sets to create one dataset
2. Extract the measurements on the mean and standard deviation for each measurement
3. Use descriptive activity names to name the activities in the dataset
4. Label the dataset with descriptive variable names
5. From the dataset in step 4, create a second, independent tidy dataset with the average of each variable for each activity and each subject

## About the Transformation Script: run_analysis.R

### Downloading and Unzipping
The Data-ZIP-File is downloaded and for simpification only needed files are unzipped in one folder.

### Loading of Metadata
The metadata is loaded into variables `ds_activity_labels` and `ds_features` and are referenced later in the script to update the data labels.

### Loading of Test and Training Data
The data for the test and training sets are split up into three specific sections being:

- subject (subject_test.txt / subject_train.txt)
- features (X_test.txt / X_train.txt)
- activity (y_test.txt / y_train.txt)

The test and training Data are loaded into the variables `ds_test_s`, `ds_test_x`, `ds_test_y` and `ds_train_s`, `ds_train_x`, `ds_train_y`.

### Preparing the Test and Training Dataset
Each of the six datasets is prepared:

- Prepares a subject (s) dataset: Appropriately labels the dataset with descriptive variable names.
- Prepares a feature (x) dataset: Uses descriptive activity names to name the activities in the dataset.
- Prepares a activity (y) dataset: Appropriately labels the dataset with descriptive variable names.

### Merging the Test and Training Dataset
Test and Training data of subject, feature and activity are row-merged with `rbind()` into the variables `ds_s` (subjects), `ds_x` (features) and `ds_y` (activities). After that the three data tables are col-merged with `cbind()` into the variable `ds_m`.

### Extract the Measurement for Means and Standard Deviation
The `grep` command is used to filter columns that contain Mean or Std. The `ds_e` variable is defined that consists of `extracted data`.

### Create and Export a Tidy Dataset
Create a second, independent tidy dataset with the average of each variable for each activity and each subject.

A variable called `tidydata` is created as a dataset with average for each activity and subject. Then the entries are ordered and then written out as data file Tidy.txt that contains the processed data. 


