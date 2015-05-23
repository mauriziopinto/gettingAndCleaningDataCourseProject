# Getting and Cleaning Data - Course project
Maurizio Pinto  



#Introduction

##Source

Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1. Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2. CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Data Set information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz have been captured. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The data sets (test and training) are available in the following files:

* train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_te561st.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt': subjects who performed the activity for each window sample (traning set)
* 'test/subject_test.txt': subjects who performed the activity for each window sample (test set)

A vector of features was obtained by calculating variables from the time and frequency domain. The features (561 in totals) have labels that need be adjusted to be easier to read and understand:




```
##  [1] tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
##  [4] tBodyAcc-std()-X  tBodyAcc-std()-Y  tBodyAcc-std()-Z 
##  [7] tBodyAcc-mad()-X  tBodyAcc-mad()-Y  tBodyAcc-mad()-Z 
## [10] tBodyAcc-max()-X 
## 477 Levels: angle(tBodyAccJerkMean),gravityMean) ...
```



##Available data

For each record it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

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

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean


##Goals

Prepare tidy data that can be used for later analysis.

#Cleaning the data set


The first steps in the transformation pipeline are meant to load all the necessary files.  The names of the columns have been set already in such a way that it is easier to understand the meaning of the variables they contain. As well, the activity IDs (numeric) have been replaced with descriptive labels (WALKING, LAYING, etc)




```r
head(test.subject, 3)
```

```
##   subject
## 1       2
## 2       2
## 3       2
```

```r
head(train.subject, 3)
```

```
##   subject
## 1       1
## 2       1
## 3       1
```

```r
head(test.y ,3)
```

```
##   activity_id activity_name
## 1           1       WALKING
## 2           1       WALKING
## 3           1       WALKING
```

```r
head(train.y,3)
```

```
##   activity_id activity_name
## 1           1       WALKING
## 2           1       WALKING
## 3           1       WALKING
```

The test and train data sets contain 561 columns.

As we are only interested to the measurements on the mean and standard deviation, a subset of the test and train datasets has been extracted that only contains the colums which names contain the lowercase strings "mean" or "std".



After the removal of unnecessary columns, the data sets contain 79 columns.

The test and training data sets contain respectively:

* 2947 observations 
* 7352 observations 



After the data sets have been combined into one, the total number of observations is 10299



In order to improve the readability of the data sets, some simple rules have been applied to the column names:

* "t" at the beginning of the name has been expanded to "time"
* "f" at the beginning of the name has been expanded to "frequency"
* "Acc" has been expanded to "Accelerometer"
* "Gyro" has been expanded to "Gyroscope"
* "Mag" has been expanded to "Magnitude"
* occurrences of "BodyBody" have been replaced with "Body"

The next steps are meant to obtain a tidy data set with the following characteristics:

1. Each variable measured is in one column
2. Each different observation of that variable is in a different row

In order to do so, we first obtain a molten data set and then we cast (with the _mean_ function) using the following formula:

_subject + activity_name ~ variable_



After the cleaning, the tidy data set is (first 5 rows, 3 columns only):

```r
means[1:5, 1:3]
```

```
##   subject    activity_name timeBodyAccelerometer.mean...X
## 1       1          WALKING                      0.2656969
## 2       2          WALKING                      0.2731131
## 3       3          WALKING                      0.2734287
## 4       4          WALKING                      0.2770345
## 5       4 WALKING_UPSTAIRS                      0.2696859
```


The tidy data set is finally saved to disk for later analysis. A copy of the data set is available on GitHub at [https://github.com/mauriziopinto/gettingAndCleaningDataCourseProject](https://github.com/mauriziopinto/gettingAndCleaningDataCourseProject)
