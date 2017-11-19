## Assignment: Getting and Cleaning Data Course Project
## 
## Source: https://github.com/peterhecker65/getting-and-cleaning-data-course-project
## 

# =========================================
# Helper functions
# =========================================

# Reads a file in table format and creates a data frame from it
# Arguments: 
#     ... character vectors
# Value:  
#     A data frame (data.frame) containing a representation of the data in the file.
read_table <- function (...) {
    file <- file.path(...)
    
    # From the book: R Programming for Data Science
    # chapter 6.3 Reading in Larger Datasets with read.table
    initial <- read.table(file, header = FALSE, nrows = 100, comment.char = '')
    classes <- sapply(initial, class)
    read.table(file, header = FALSE, colClasses = classes, comment.char = '')
}

# Prepares a subject (s) dataset
# Arguments: 
#     ds - dataset
#     col_names - name of columns
# Value:  
#     the prepared dataset
prepare_ds_s <- function(ds, col_names) {
    names(ds) <- col_names
    ds
}

# Prepares a feature (x) dataset
# Arguments: 
#     ds - dataset
#     col_names - name of columns
# Value:  
#     the prepared dataset
prepare_ds_x <- function(ds, col_names) {
    col_names <- gsub('^f', 'Frequency', col_names)
    col_names <- gsub('^t', 'Time', col_names)
    col_names <- gsub('Acc', 'Accelerometer', col_names)
    col_names <- gsub('angle', 'Angle', col_names)
    col_names <- gsub('BodyBody', 'Body', col_names)
    col_names <- gsub('gravity', 'Gravity', col_names)
    col_names <- gsub('Gyro', 'Gyroscope', col_names)
    col_names <- gsub('Mag', 'Magnitude', col_names)
    col_names <- gsub('tBody', 'TimeBody', col_names)
    
    col_names <- gsub('[()]', '', col_names)
    
    col_names <- gsub('-mean-', 'Mean', col_names)
    col_names <- gsub('-std-', 'Std', col_names)
    col_names <- gsub('-mad-', 'Mad', col_names)
    col_names <- gsub('-max-', 'Max', col_names)
    col_names <- gsub('-min-', 'Min', col_names)
    col_names <- gsub('-sma-', 'Sma', col_names)
    col_names <- gsub('-energy-', 'Energy', col_names)
    col_names <- gsub('-iqr-', 'Iqr', col_names)
    col_names <- gsub('-entropy-', 'Entropy', col_names)
    col_names <- gsub('-arCoeff-', 'ArCoeff', col_names)
    col_names <- gsub('-correlation-', 'Correlation', col_names)
    col_names <- gsub('-maxInds-', 'MaxInds', col_names)
    col_names <- gsub('-meanFreq-', 'MeanFreq', col_names)
    col_names <- gsub('-skewness-', 'Skewness', col_names)
    col_names <- gsub('-kurtosis-', 'Kurtosis', col_names)
    col_names <- gsub('-bandsEnergy-', 'BandsEnergy', col_names)
    col_names <- gsub('-angle-', 'Angle', col_names)
    
    col_names <- gsub('[-, \\,\\]', '_', col_names)
    
    names(ds) <- col_names
    ds
}

# Prepares a activity (y) dataset
# Arguments: 
#     ds - dataset
#     col_names - name of columns
#     ds_activity_labels - data frame of activity labels
# Value:  
#     the prepared dataset
prepare_ds_y <- function(ds, col_names, ds_activity_labels) {
    names(ds) <- col_names
    ds$Activity <- factor(ds$Activity, 
                          levels = ds_activity_labels$V1, 
                          labels = ds_activity_labels$V2)
    ds
}

# =========================================
# Step 1: Download and save ZIP-file
# =========================================
# the source
ds_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# the destination
ds_destfile <- 'getdata-projectfiles-UCI-HAR-Dataset.zip'

# Download ZIP-file
download.file(ds_url, destfile = ds_destfile, method = 'curl')

# =========================================
# Step 2: Extract needed files
# =========================================
# List of needed files in ZIP-file 
# - 'activity_labels.txt': Links the class labels with their activity name.
# - 'features.txt': List of all features.
# - 'features_info.txt': Shows information about the variables used on the feature vector.
# - 'train/X_train.txt': Training set.
# - 'train/y_train.txt': Training labels.
# - 'test/X_test.txt': Test set.
# - 'test/y_test.txt': Test labels.

ds_files <- c('UCI HAR Dataset/activity_labels.txt',
              'UCI HAR Dataset/features.txt',
              'UCI HAR Dataset/test/subject_test.txt',
              'UCI HAR Dataset/test/X_test.txt',
              'UCI HAR Dataset/test/y_test.txt',
              'UCI HAR Dataset/train/subject_train.txt',
              'UCI HAR Dataset/train/X_train.txt',
              'UCI HAR Dataset/train/y_train.txt')

# Local folder to store needed files
ds_exdir <- 'UCI-HAR-Dataset'

# Extract needed files from ZIP-file in local folder
unzip(ds_destfile, files = ds_files, overwrite = TRUE, junkpaths = TRUE, exdir = ds_exdir)

# =========================================
# Step 3: Load files into data frames
# =========================================

ds_activity_labels = read_table(ds_exdir, 'activity_labels.txt')
ds_features = read_table(ds_exdir, 'features.txt')

ds_test_s = read_table(ds_exdir, 'subject_test.txt')
ds_test_x = read_table(ds_exdir, 'X_test.txt')
ds_test_y = read_table(ds_exdir, 'y_test.txt')

ds_train_s = read_table(ds_exdir, 'subject_train.txt')
ds_train_x = read_table(ds_exdir, 'X_train.txt')
ds_train_y = read_table(ds_exdir, 'y_train.txt')

# =========================================
# Step 4: Prepare the Datasets
# =========================================

# Appropriately labels the dataset with descriptive variable names.
ds_test_s <- prepare_ds_s(ds_test_s, 'Subject')
ds_train_s <- prepare_ds_s(ds_train_s, 'Subject')

# Uses descriptive activity names to name the activities in the dataset
ds_test_x <- prepare_ds_x(ds_test_x, ds_features$V2)
ds_train_x <- prepare_ds_x(ds_train_x, ds_features$V2)

# Appropriately labels the dataset with descriptive variable names.
ds_test_y <- prepare_ds_y(ds_test_y, 'Activity', ds_activity_labels)
ds_train_y <- prepare_ds_y(ds_train_y, 'Activity', ds_activity_labels)

# =========================================
# Step 5: Merge the Datasets
# =========================================

# Merges the test and the training datasets to create one dataset.
ds_s <- rbind(ds_test_s, ds_train_s)
ds_x <- rbind(ds_test_x, ds_train_x)
ds_y <- rbind(ds_test_y, ds_train_y)

ds_m <- cbind(ds_s, ds_y, ds_x)

# =========================================
# Step 5: Extract the Datasets and Export
# =========================================

# Extracts only the measurements on the mean and standard deviation for each measurement.
col_names_e <- grep('.*Subject.*|.*Activity.*|.*Mean.*|.*Std.*', x = names(ds_m), ignore.case = TRUE)
ds_e <- ds_m[, col_names_e]

# Create a second, independent tidy dataset with the average of each variable for each activity and each subject.
tidydata <- aggregate(. ~Subject + Activity, ds_e, mean)
tidydata <- tidydata[order(tidydata$Subject, tidydata$Activity),]

# Export to file
write.table(tidydata, file = file.path(ds_exdir, 'tidydata.txt'), row.name = FALSE)
