# GettingAndCleaningData-Project

## How does it work. 
The Run_Analysis.R file works as follows:

1. Create full datasets in R by reading the subject, Y and X files (for train and test) 
    Subject files identify who performs the activities
    Y files identify the types of activities performed
    X files contain the measurements 
    
2. Prepend the subject data, activity (Y) data to each row of the X data(the measurements
  at this point, for each line we have a complete description of who, what, how, but it's still broken into two pieces (training and testing data)
  
3. Merge training and testing data. 
  We now have answered point 1 of the instructions.

5. Read in the features dataset to give descriptive names for all the measurements
  We now have answered point 4

1. Only select the measurements that contain either mean or avg in their descriptive name. 
  We now have answered point 2

6. Use the feature dataset to name each and every variable in the large data table. The first two columns contain subject_id and activity id

4. Read in the activity dataset which gives us descriptive names for the activity types

5. Add a column to the data to link each activity_id to an activity_label
  We now have answered point 3
  
1. Grouping data by activity, we create a tidy data set to output.


## Code Book
Tidy text contains averages for each subject and each activity, for each of 79 measurements (e.g 81 columns)
Since there are 30 subjects and 6 activities, there are 180 rows. 

Variables in tidy.txt are:

**Activity**
  - this is one of walking, walking_upstairs, walking_downstairs, sitting, standing, laying
  
**Subject**
  - this is the anonymised subject id. 
  - subjects 2,4,9,10,12,13,18,20,24 where test subjects
  - subjects 1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25  26  27  28  29  30  where training subjects
  
**Measurements**
  - Measurements are described using the following code:
      * t for time based measurement, f for frequency based
      * Body describes the actual movement component of the measurement, Gravity the component linked to gravitational pull
      * Gyro is a measurement taken from a gyroscope, and Acc from an accelerometer
      * Mag and Jerk describe either the magnitude or the jerk component 
      * finally X,Y,Z describe which component of the measurement vector is described.
      
      * avg and std describe either an average value or a std deviation.
  


