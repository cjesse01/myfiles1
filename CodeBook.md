##FILE: CodeBook.md
###AUTHOR: cjesse01
###DETAILS: This markdown file is the Code Book for the file tidydata2.txt.  
###Thank you for your Peer Assessment! :)

##Code Book For:
###DATA FILE: tidydata2.txt
###FILE TYPE: tab delimited file, with header row 1, in tall/skinny layout      		
###ROWS: 11880
###COLS: 4
###ROW IDENTIFICATION:  a row in the data is uniquely identified by the combination of subjectNBR + activityDESC + featureDESCstandard

##Column Number: 1
###Column Name: subjectNBR
###R Type: int
###values: integers 1:30, which is a unique identifier for the subject (person in study)

##Column Number: 2
###Column Name: activityDESC
###R Type: Factor w/ 6 levels
###values: descriptor for the 6 types of activities performed by each subject
###WALKING
###WALKING_UPSTAIRS
###WALKING_DOWNSTAIRS
###SITTING
###STANDING
###LAYING

##Column Number: 3
###Column Name: featureDESCstandard
###R Type: Factor w/ 66 levels
###values: The 66 levels of the field are the standardized feature descriptions, representing 33 chosen features, either thier mean() or std() measure. Standardardization simply removes the punctuation. Example: the feature description tBodyAcc-mean()-X is standardized to tBodyAccmeanX.

##Column Number: 4
###Column Name: mean
###R Type: num
###values: The 'mean' column is the average for the featureDESCstandard, across all rows of tidydata1 (the combined train and test data, in short/wide format), for a particular subjectNBR and ativityDESC combination.
