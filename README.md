GettingCleaningDataCoursera
===========================

#this directory includes the following files:
* 'README.md'
* 'tidydata.txt' : tidy data set with the average variable for each subject and each activity
* 'run_analysis.R' : R script use to transform raw data set
* 'CodeBook.md' : names of variables on tidy data set. quick explanation of these variables. type of variables


# Using run_analysis.R script
* download run_annalysis.R
* source the script
* the script has been written in this environment:  
> sessionInfo()
R version 3.0.2 (2013-09-25)
Platform: x86_64-w64-mingw32/x64 (64-bit)

locale:
[1] LC_COLLATE=French_France.1252  LC_CTYPE=French_France.1252   
[3] LC_MONETARY=French_France.1252 LC_NUMERIC=C                  
[5] LC_TIME=French_France.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

loaded via a namespace (and not attached):
[1] tools_3.0.2

# R script logic
1. the script will download data from the url.
2.it create a directory called 'data' if it doesn't exist
3. unzip the zip file
4. Merge the training and the test set
5. extract the mean and std for each measurement
6. use full descriptive activity names to name the activities
7. label the data set with descriptive variable names.
8. aggregate the average of eache activity and subject variables.
9. write tidy data set to file

# RAW DATA and its source
* zip file is loaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* the zip file includes this following we use for transformation:  
1. 'README.txt'

2. 'features_info.txt': Shows information about the variables used on the feature vector.

3. 'features.txt': List of all features.

4. 'activity_labels.txt': Links the class labels with their activity name.

5. 'train/X_train.txt': Training set.

6. 'train/y_train.txt': Training labels.

7. 'test/X_test.txt': Test set.

8. 'test/y_test.txt': Test labels.



