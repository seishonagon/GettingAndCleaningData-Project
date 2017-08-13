# ## Course Project ## Script ## Assignment description # The data linked to
# from the course website represent data collected from the accelerometers #
# from the Samsung Galaxy S smartphone. A full description is available at the
# site where the # data was obtained:
# 
# #
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# # Here are the data for the project:
# 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
# 1 Merges the training and the test sets to create one data set. 
# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3 Uses descriptive activity names to name the activities in the data set 
# 4 Appropriately labels the data set with descriptive variable names. 
# 5 From the data set in step 4, creates a second, independent tidy data set with the
#   average of each variable for each activity and each subject.
library(dplyr)
rm(list = ls())
# Create subject dataset (who performed each line)

ifelse(file.exists("./UCI HAR Dataset/test/subject_test.txt"), 
       subject_test <- tbl_df(read.table("./UCI HAR Dataset/test/subject_test.txt")), 
       print("File ./UCI HAR Dataset/test/subject_test.txt does not exist"))

ifelse(file.exists("./UCI HAR Dataset/train/subject_train.txt"), 
       subject_train <- tbl_df(read.table("./UCI HAR Dataset/train/subject_train.txt")), 
       print("File ./UCI HAR Dataset/train/subject_train.txt does not exist"))

# Create Y  dataset (what activities where performed on each line)

ifelse(file.exists("./UCI HAR Dataset/test/Y_test.txt"), 
       Y_test <- tbl_df(read.table("./UCI HAR Dataset/test/Y_test.txt")), 
       print("File ./UCI HAR Dataset/test/Y_test.txt does not exist"))

ifelse(file.exists("./UCI HAR Dataset/train/Y_train.txt"), 
       Y_train <- tbl_df(read.table("./UCI HAR Dataset/train/Y_train.txt")), 
       print("File ./UCI HAR Dataset/train/Y_train.txt does not exist"))

# Create X  dataset (measurements for each activities)

ifelse(file.exists("./UCI HAR Dataset/test/X_test.txt"), 
       X_test <- tbl_df(read.table("./UCI HAR Dataset/test/X_test.txt")), 
       print("File ./UCI HAR Dataset/test/X_test.txt does not exist"))

ifelse(file.exists("./UCI HAR Dataset/train/X_train.txt"), 
       X_train <- tbl_df(read.table("./UCI HAR Dataset/train/X_train.txt")), 
       print("File ./UCI HAR Dataset/train/X_train.txt does not exist"))

# Merge training datasets together. Each row of the X_train data measurements is prefaced by the 
# corresponding row of the subject_train data (who did the activity) and the corresponding row of the
# Y_train data (what activity was it)

train_data <- bind_cols(subject_train, Y_train, X_train)

# Do the same for the test dataset
test_data <- bind_cols(subject_test, Y_test, X_test)

# Merge train and test data in one large dataset by combining training and test rows

data <- bind_rows(train_data, test_data)

# Read activity dataset 

ifelse(file.exists("./UCI HAR Dataset/activity_labels.txt"), 
       activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("id","variables"), stringsAsFactors = FALSE), 
       print("File ./UCI HAR Dataset/activity_labels.txt does not exist"))

# Create features dataset (names of variables)

ifelse(file.exists("./UCI HAR Dataset/features.txt"), 
       features <- read.table("./UCI HAR Dataset/features.txt",col.names = c("id","variables"), stringsAsFactors = FALSE), 
       print("File ./UCI HAR Dataset/features.txt does not exist"))

# Create names for all columns in data table
varNames <- features[["variables"]]
varNames <- c("subject","activity", varNames)
names(data) <- varNames

# Keep only the first two columns (subject and activity) and the variables whose names contain either mean() or std()
select_data <- data[grepl('subject|activity|*mean()*|*std()*', names(data))]

# Add descriptive names to the activities by merging in the activity_labels table
merge_data <- merge(activity_labels, select_data, by.x = "id", by.y = "activity")
merge_data <- merge_data %>%
  select(-id) %>%
  rename(activity = variables)

# Group data by activity and subject to make summary easier
grouped_data <- group_by(merge_data, activity, subject)

# Create dataset containing the average of each activity for each subject
summary <- summarize_all(grouped_data, mean)
write.table(summary, file = "tidy_data.txt", row.names = FALSE)
