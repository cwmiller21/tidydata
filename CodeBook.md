# Explanation of the data found in the tidydata and tidydata2 files.

## Original Data

  The data come from Human Activity Recognition Using Smartphones Data Set which can be located at
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
  The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

## tidydata

  The original data described above was loaded into R using run_analysis.R.  The data presented split between 3 folders were merged into one data set. The columns of the resultant data set were
  * Subject -- number 1 to 30
  * Activity -- six of them (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
  * Feature Columns
    
        The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

        Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

        Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

        These signals were used to estimate variables of the feature vector for each pattern:  
        '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

        Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

        These signals were used to estimate variables of the feature vector for each pattern:  
        '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

        * tBodyAcc-XYZ
        * tGravityAcc-XYZ
        * tBodyAccJerk-XYZ
        * tBodyGyro-XYZ
        * tBodyGyroJerk-XYZ
        * tBodyAccMag
        * tGravityAccMag
        * tBodyAccJerkMag
        * tBodyGyroMag
        * tBodyGyroJerkMag
        * fBodyAcc-XYZ
        * fBodyAccJerk-XYZ
        * fBodyGyro-XYZ
        * fBodyAccMag
        * fBodyAccJerkMag
        * fBodyGyroMag
        * fBodyGyroJerkMag
        
17 different summary measures were applied to the signals.  The focus of the tidydata was only on two of the measures.

    mean(): Mean value
    std(): Standard deviation

### Manipulations
A subset of the merged data set was selected to have only those features which had 'mean' or 'std' in there description.

The column names of the tidydata were modified to remove any '('  ')'  ',' and replace '-' with a '.'


The tidydata consists of 10299 observations with 81 columns.  The columns are Subject, Activity and 79 feature columns.

  
## tidydata2

A second, independent tidy data set was created where the average of each of the 79 features for each activity and each subject was created.

The tidydata2 set consists of 180 observations with 81 columns.




