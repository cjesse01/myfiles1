##FILE: CodeBook.md
###AUTHOR: cjesse01
##Code Book For:
###DATA FILE: tidydata2.txt
###FILE TYPE: tab delimited file, with header row 1, in tall/skinny layout      		
###ROWS: 11880
###COLS: 4
###ROW IDENTIFICATION:  a row in the data is uniquely identified by the combination of subjectNBR + activityDESC + featureDESCstandard

##Column Number: 1
###Column Name: subjectNBR
###R Type: int
###values: integers 1:30, which is a unique identifier for the subject (the person in study)
###Notes: test group comprised of 9 subjects with subjectNBR={2, 4, 9, 10, 12, 13, 18, 20, 24}.  All others are train group.


##Column Number: 2
###Column Name: activityDESC
###R Type: Factor w/ 6 levels
###values: descriptor for the 6 types of activities performed by each subject: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

##Column Number: 3
###Column Name: featureDESCstandard
###R Type: Factor w/ 66 levels
###values: 66 levels
* tBodyAccmeanX : mean of body acceleration signal, time domain, X coordinate
* tBodyAccmeanY : mean of body acceleration signal, time domain, Y coordinate
* tBodyAccmeanZ : mean of body acceleration signal, time domain, Z coordinate
* tBodyAccstdX : standard deviation of body acceleration signal, time domain, X coordinate
* tBodyAccstdY : standard deviation of body acceleration signal, time domain, Y coordinate
* tBodyAccstdZ : standard deviation of body acceleration signal, time domain, Z coordinate
* tGravityAccmeanX : mean of gravity acceleration signal, time domain, X coordinate
* tGravityAccmeanY : mean of gravity acceleration signal, time domain, Y coordinate
* tGravityAccmeanZ : mean of gravity acceleration signal, time domain, Z coordinate
* tGravityAccstdX : standard deviation of gravity acceleration signal, time domain, X coordinate
* tGravityAccstdY : standard deviation of gravity acceleration signal, time domain, Y coordinate
* tGravityAccstdZ : standard deviation of gravity acceleration signal, time domain, Z coordinate
* tBodyAccJerkmeanX : mean of body acceleration jerk signal, time domain, X coordinate
* tBodyAccJerkmeanY : mean of body acceleration jerk signal, time domain, Y coordinate
* tBodyAccJerkmeanZ : mean of body acceleration jerk signal, time domain, Z coordinate
* tBodyAccJerkstdX : standard deviation of body acceleration jerk signal, time domain, X coordinate
* tBodyAccJerkstdY : standard deviation of body acceleration jerk signal, time domain, Y coordinate
* tBodyAccJerkstdZ : standard deviation of body acceleration jerk signal, time domain, Z coordinate
* tBodyGyromeanX : mean of body gyroscope signal, time domain, X coordinate
* tBodyGyromeanY : mean of body gyroscope signal, time domain, Y coordinate
* tBodyGyromeanZ : mean of body gyroscope signal, time domain, Z coordinate
* tBodyGyrostdX : standard deviation of body gyroscope signal, time domain, X coordinate
* tBodyGyrostdY : standard deviation of body gyroscope signal, time domain, Y coordinate
* tBodyGyrostdZ : standard deviation of body gyroscope signal, time domain, Z coordinate
* tBodyGyroJerkmeanX : mean of body gyroscope jerk signal, time domain, X coordinate
* tBodyGyroJerkmeanY : mean of body gyroscope jerk signal, time domain, Y coordinate
* tBodyGyroJerkmeanZ : mean of body gyroscope jerk signal, time domain, Z coordinate
* tBodyGyroJerkstdX : standard deviation of body gyroscope jerk signal, time domain, X coordinate
* tBodyGyroJerkstdY : standard deviation of body gyroscope jerk signal, time domain, Y coordinate
* tBodyGyroJerkstdZ : standard deviation of body gyroscope jerk signal, time domain, Z coordinate
* tBodyAccMagmean : mean of body acceleration magnitude, time domain
* tBodyAccMagstd : standard deviation of body acceleration magnitude, time domain
* tGravityAccMagmean : mean of gravity acceleration magnitude, time domain
* tGravityAccMagstd : standard deviation of gravity acceleration magnitude, time domain
* tBodyAccJerkMagmean : mean of body acceleration jerk magnitude, time domain
* tBodyAccJerkMagstd : standard deviation of body acceleration jerk magnitude, time domain
* tBodyGyroMagmean : mean of body gyroscope magnitude, time domain
* tBodyGyroMagstd : standard deviation of body gyroscope magnitude, time domain
* tBodyGyroJerkMagmean : mean of body gyroscope jerk magnitude, time domain
* tBodyGyroJerkMagstd : standard deviation of body gyroscope jerk magnitude, time domain
* fBodyAccmeanX : mean of body acceleration signal, frequency domain, X coordinate
* fBodyAccmeanY : mean of body acceleration signal, frequency domain, Y coordinate
* fBodyAccmeanZ : mean of body acceleration signal, frequency domain, Z coordinate
* fBodyAccstdX : standard deviation of body acceleration signal, frequency domain, X coordinate
* fBodyAccstdY : standard deviation of body acceleration signal, frequency domain, Y coordinate
* fBodyAccstdZ : standard deviation of body acceleration signal, frequency domain, Z coordinate
* fBodyAccJerkmeanX : mean of body acceleration jerk signal, frequency domain, X coordinate
* fBodyAccJerkmeanY : mean of body acceleration jerk signal, frequency domain, Y coordinate
* fBodyAccJerkmeanZ : mean of body acceleration jerk signal, frequency domain, Z coordinate
* fBodyAccJerkstdX : standard deviation of body acceleration jerk signal, frequency domain, X coordinate
* fBodyAccJerkstdY : standard deviation of body acceleration jerk signal, frequency domain, Y coordinate
* fBodyAccJerkstdZ : standard deviation of body acceleration jerk signal, frequency domain, Z coordinate
* fBodyGyromeanX : mean of body gyroscope signal, frequency domain, X coordinate
* fBodyGyromeanY : mean of body gyroscope signal, frequency domain, Y coordinate
* fBodyGyromeanZ : mean of body gyroscope signal, frequency domain, Z coordinate
* fBodyGyrostdX : standard deviation of body gyroscope signal, frequency domain, X coordinate
* fBodyGyrostdY : standard deviation of body gyroscope signal, frequency domain, Y coordinate
* fBodyGyrostdZ : standard deviation of body gyroscope signal, frequency domain, Z coordinate
* fBodyAccMagmean : mean of body acceleration magnitude, frequency domain
* fBodyAccMagstd : standard deviation of body acceleration magnitude, frequency domain
* fBodyBodyAccJerkMagmean : mean of body acceleration jerk magnitude, frequency domain
* fBodyBodyAccJerkMagstd : standard deviation of body acceleration jerk magnitude, frequency domain
* fBodyBodyGyroMagmean : mean of body gyroscope magnitude, frequency domain
* fBodyBodyGyroMagstd : standard deviation of body gyroscope magnitude, frequency domain
* fBodyBodyGyroJerkMagmean : mean of body gyroscope jerk magnitude, frequency domain
* fBodyBodyGyroJerkMagstd : standard deviation of body gyroscope jerk magnitude, frequency domain

##Column Number: 4
###Column Name: mean
###R Type: num
###values: The 'mean' column is the average for the featureDESCstandard, across all rows of tidydata1 (the combined train and test data, in short/wide format), for a particular subjectNBR and ativityDESC combination.

##FIN... :)
###Thank you for your Peer Assessment! :)

