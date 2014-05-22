##FILE: README.md
###AUTHOR: cjesse01
###Thank you for your Peer Assessment! :) Please forgive my very basic markdown.
###DETAILS: This markdown file describes the process used to create tidydata2.txt. 
###It includes discussion of all steps:
* Download and unzip of the zip file at the website
* Data Exploration and conclusions to logical decisions and reasoning used along the way. 
* Process Flow and description of the major steps contained within the run_analysis.R program that creates tidydata2.txt


##PRELIMINARY STEPS
###i) DOWNLOAD AND UNZIP the data file from the website, per instructions
###Autogenerated directories and files with the unzip:
### ./UCI HAR Dataset, files used:
*     features_info.txt   (documentation)
*     README.txt          (documentation)
*     activity_labels.txt (data: mapping of activity number to description)
*     features.txt        (data: list of feature measurement names)

### ./UCI HAR Dataset/train, files used:
*     X_train.txt         (data: feature measurements for the TRAINing group)
*     y_train.txt         (data: activity number associated with the rows of X_.txt)
*     subject_train.txt   (data: subject number associated with the rows of X_.txt)

### ./UCI HAR Dataset/test, files used:
*     X_test.txt          (data: feature measurements for the TESTing group)
*     y_test.txt          (data: activity number associated with the rows of X_.txt
*     subject_test.txt    (data: subject number associated with the rows of X_.txt)

### ./UCI HAR Dataset/test/Inertial Signals, this data not needed
### ./UCI HAR Dataset/train/Inertial Signals, this data not needed

###ii) DATA EXPLORATION CONCLUSIONS
###After reading all the data documentation, the project instructions, and working with the above 8 data files in their raw state, I drew the following conclusions. These conclusions drive the manipulation of the data in run_analysis.R.
* Conclusion1: Thirty-three variables of the feature vector are listed in the features_info.txt document. These 33 variables each have a mean() and std() estimate in the features.txt data, and thus this drives the 66 columns (of 561 available) chosen to extract from the X_.txt files.
* Conclusion2: For my column names in X_.txt, I descided to standardize the feature descriptions in feature.txt by stripping out only punctuation, but keeping the mixed case nature of the labels. For example:  the feature description tBodyAcc-mean()-X was standardized to tBodyAccmeanX as the associated column name in X_.txt. I did this to maintain the language of the data, as estabished by the authors of the data documentation. I felt it was easier to visually tie back to the documentation this way also.
* Conclusion3: The 561 rows of features.txt are dimensionally alligned to the 561 columns of the X_.txt files.  In other words, row 1 of features.txt describes col 1 in the X_.txt files; row 2 features.txt describes column 2 X_.txt, etc.
* Conclusion4: The row counts are the same for the files X_.txt, y_.txt, and subject_.txt. Thus the original row order is used to marry the activity and subject specification to each row of the X_.txt data.

##PROCESS FLOW run_analysis.R
###NOTE: within run_analysis.R there are many comment lines. In addition, with each R object creation, I include a variety of diagnostics to assess the object accuracy: str(), head(), tail(), unique(), xtabs(), summary(), etc, as appropriate for checking quality. I hope I will not get downgraded for leaving these diagnostics in the program.

##READ/SHAPE data files in directory ./UCI HAR Dataset
###1) Read/Shape activity_labels.txt
* Result: dataframe: activity, 6 rows x 2 cols, activityNBR and activityDESC

###2) Create a feature positional vector
* Based on Conclusion1, manually make a 'positional vector' for extracting the 66 columns of X_.txt.  This is a simple vector of the associated 66 featureNBRs.
* Result: vector: featurelist66, 66 rows x 1 cols, integer

###3) Read/Shape feature.txt
* Result: dataframe: feature, 561 rows x 2 cols, featureNBR and featureDESC
* Use the featurelist66 vector to subset 66 rows and create a standardized feature label festureDESCstandard (see Conclusion2)
* Result: dataframe: feature66, 66 rows x 3 cols, featureNBR, featureDESC, featureDESCstandard
   
   
##READ/SHAPE TRAINing data files in ./UCI HAR Dataset/train
###A) Read and Process X_train.txt, the feature values file
* Read the file into R. Use the featurelist66 vector to subset the 66 columns. Use the feature66 dataframe to name the 66 columns. Create a record tracer, recTRACER, that can be used in joins and for sorting back to the original row order where needed.
* Result: dataframe: X_wID, 7352 rows x 67 cols, recTRACER and 66 features

###B) Read and Process y_train.txt, the activity map for X_train.txt
* Read the file into R. Create a record tracer, recTRACER, that can be used in joins and for sorting back to the original row order where needed. Use the activity dataframe to marry activity description, activityDESC, to each row of y_.txt via activityNBR.
* Result: dataframe: y_wID3,  7352 rows x 3 cols, recTRACER, activityNBR, activityDESC

###C) Read and Process subject_train.txt, the subject map for X_train.txt
* Read the file into R. Create a record tracer, recTRACER, that can be used in joins and for sorting back to the original row order where needed.
* Result: dataframe: subject_wID, 7352 rows x 2 cols, recTRACER and subjectNBR

###D) Create the FINAL TRAIN DATA SET
* Merge the dataframes subject_wID, y_wID3, and X_wID via the recTRACER. 
* Add a column subjectgroup that has the value "TRAIN" for every record.
* Result: dataframe: traindatafinal, 7352 rows x 71 cols, subjectgroup, recTRACER, subjectNBR, activityNBR, activityDESC, and 66 feature columns


##READ/SHAPE TESTing data files in ./UCI HAR Dataset/test
###Steps E), F), G), H) are a repeat of Steps A), B), C), D), respectively, but for the test files.
* Result: dataframe: testdatafinal, 2947 rows x 71 cols, subjectgroup (set to "TEST"), recTRACER, subjectNBR, activityNBR, activityDESC, and the 66 feature columns.

##MERGE the TEST and TRAIN data frames
###I) Combine the TRAIN and TEST data into one Tidy Data Set
* rbind() the traindatafinal and testdatafinal dataframes.
* write the data frame out to the WD as a comma delimited .csv.
* this is the FIRST tidy data set, a "short and wide" layout
* the combination of subjectNBR, activityNBR (or activityDESC), and recTRACER uniquely identifies a row
* RESULT: ./tidydata1.csv, 10299 rows x 71 cols, as expected.

###J) Create a SECOND tidy data set from tidydata1
* read tidydata1.csv into R. 
* use melt() on the file to get it into a tall skinny format.  
* manipulate the subjectNBR and activityDESC columns into new column, subjectNBR_activityDESC, for use with dcast() to get the means on all 66 features
* use melt() again to make the means file tall and skinny
* use colSplit() on subjectNBR_activityDESC column to break back into its components 
* spot check the calculation for some test cases to ensure process is correct
* write the data frame out to the WD as a tab delimited .txt
* this is the SECOND tidy data set, a "tall and skinny" layout
* since tidydata2.txt is "tall and skinny", row count 11880 is 30 (subjects) x 6 (activities) x 66 (features).
* the combination of subjectNBR, activityNBR, and featureDESCstandard uniquely identifies a row in tidydata2. 
* the mean column in tidydata2 is the average feature value, across all rows of tidydata1, for a particular subjectNBR and ativityDESC.
* RESULT: ./tidydata2.txt, 11880 rows x 4 cols, subjectNBR, activityDESC, featureDESCstandard, and mean
