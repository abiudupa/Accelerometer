Accelerometer Course Project CodeBook
======================================
 
STEPS :
-------

1. Download data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename folder data  
2. Run  run_analysis.R which reads the training data first X_train.txt, y_train.txt and subject_train.txt from the train subfolder and stores them in *trainX*, *trainY* and *trainS* variables.       
3. Reads X_test.txt, y_test.txt and subject_test.txt from the test subfolder and stores them in *testX*, *testY* and *testS* variables.  
4. Combines *trainX* and *testX* to generate  *combineX*; *trainY* and *testY* to generate *combineY*; *trainS* and *testS* to generate *combineS*.  
5. Loads contents of features.txt file into *features* and extracts the measurements on the mean and standard deviation.
6. Cleans the column names by removing  "()" and "-" symbols and replaces "mean" by "Mean" and "std" by "Std" respectively.   
7. Loads contents of activity_labels.txt file into *activity*.  
8. Cleans second column of *activity* by making all names into lower cases. 
9. Combines *combineS*, *combineY* and *combineX* into *final* with 66 columns. 
10. Writes *final* out to "combine.txt" file.  
11. Generates tidy data set with the average of each measurement for each activity and each subject of30 unique subjects and 6 unique activities and writes it into tidy.txt
 
