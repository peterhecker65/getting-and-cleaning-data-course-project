# CodeBook
This code book describes the  data and transformations used by `run_analysis.R` and the variables to produce the output of tidydata.txt

## The Data Source

[Original Data Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

[Original Description of the Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Dataset Information

### Input Dataset

- `activity_labels.txt` contains metadata on the different types of activities.
- `features.txt` contains the name of the features in the Datasets.
- `X_train.txt` contains variable features that are intended for training.
- `y_train.txt` contains the activities corresponding to `X_train.txt`.
- `subject_train.txt` contains information on the subjects from whom data is collected.
- `X_test.txt` contains variable features that are intended for testing.
- `y_test.txt` contains the activities corresponding to `X_test.txt`.
- `subject_test.txt` contains information on the subjects from whom data is collected.

## Transformations
The following are the transformations:

- `activity_labels.txt` is read into table `ds_activity_labels`
- `features.txt` is read into table `ds_features`
- `subject_test.txt` is read into table `ds_test_s`
- `X_test.txt` is read into table `ds_test_x`
- `y_test.txt` is read into table `ds_test_y`
- `subject_train.txt` is read into table `ds_train_s`
- `X_train.txt` is read into table `ds_train_x`
- `y_train.txt` is read into table `ds_train_y`

- The respective files for Train and Test are Subject, Activity and Features  are merged into the corresponding `ds_s`, `ds_x` and `ds_y`
- The `Subject`, `Activity` and `Features` are merged to create ‘ds_m’
- Indices of columns that contain std or mean, activity and subject are taken into `col_names_e`.
- Extracted data is created in variable `ds_e`
- `tidyData` is created as a set with average for each activity and subject of `ds_e`. Entries in `tidyData` are ordered based on activity and subject.
- Finally, the data in tidyData is written into `tidydata.txt`

## Output Dataset
The output data `tidydata.txt` is a space delimited value file. It contains the mean and standard deviation values of the data contained in the input files
