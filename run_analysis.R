###############################
## Get/Clean Data
## Course Project
## prg: run_analysis.R
## author: cjesse01
###############################

###############################
## Inputs:
## 8 unzipped files from getdata-projectfiles-UCI HAR Dataset.zip
## Outputs: tidydata1.csv, tidydata2.txt
###############################

###############################
## Instructions from Coursera
#Create one R script called run_analysis.R that does the following.
#1) Merges the training and the test sets to create one data set.
#2) Extracts only the measurements on the mean and standard deviation for each measurement.
#3) Uses descriptive activity names to name the activities in the data set
#4) Appropriately labels the data set with descriptive activity names. 
#5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###############################

# Preliminary steps:  download the .zip and unzip the contents into working directory

## auto-generated directories with unzip:
# ./UCI HAR Dataset
# ./UCI HAR Dataset/test
# ./UCI HAR Dataset/train
# ./UCI HAR Dataset/test/Inertial Signals (not needed)
# ./UCI HAR Dataset/train/Inertial Signals (not needed)

## ensure packages beyond base are loaded
library(utils)
library(stats) #needed for xtabs() and others
library(rshape2) #needed for melt() and dcast()


#######################################
## 1) Read/Shape activity_labels.txt ##
#######################################
## Read and Process activity_labels.txt, the activity number/description map
activity<-read.table("./UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
names(activity)<-c("activityNBR","activityDESC")
# diagnotics
        #head(activity,n=10)
        #str(activity) # 6 x 2, correct

##############################
## 2) Create a feature list ##
##############################
## Based on details contained in the features_info.txt file,
## as well as the 561 features in the features.txt file,
## create a "positional vector" for the 66 columns (feature mean/std) to be extracted
## this will be used to extract 66 rows from festures.txt and 66 cols from X_*.txt
featurelist66<-c(
        1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,
        266:271,345:350,424:429,503:504,516:517,529:530,542:543
               )
# diagnostics
#        length(featurelist66)
#        featurelist66

###############################
## 3) Read/Shape feature.txt ##
###############################
## Read and Process features.txt, the feature number/label map 
feature<-read.table("./UCI HAR Dataset/features.txt", sep="", header=FALSE)
names(feature)<-c("featureNBR","featureDESC")
#diagnostics
#        head(feature,n=10)
#        str(feature) # 561 x 2, correct
        # check for uniqueness of feature names
        #test1<-as.data.frame(unique(feature$featureDESC))
        #test2<-as.data.frame(unique(feature$featureNBR))
        #str(test1) #477 x 1 , DESC are not unique
        #str(test2) #561 x 1 , Unique numbers 1 to 561, but do not have unique DESC

## extract the desired 66 rows from the feature data frame using positional vector
feature66<-feature[featurelist66, ]

## create a new column with standardized names, strip out all punctuation ()_ 
feature66$featureDESCstandard=gsub("[[:punct:]]", "", feature66$featureDESC)
# diagnostics
#        str(feature66)
#        head(feature66, n=66)

## create a "names vector" for use with X_*.txt
featurenames<-feature66[, "featureDESCstandard"]
# diagnostics
#       str(featurenames)
#       featurenames


#################################
## TRAINING GROUP DATA process ##
#################################
# Files to read are in ./UCI HAR Dataset/train
# A) X_train.txt (7352 x 561, formats: +-n.nnnnnnne-00n), feature value data 
# B) y_train.txt (7352 x 1), maps activity number to each row of X_*.txt
# C) subject_train.txt (7352 x 1), maps subject number to each row of X_*.txt
# D) create the FINAL TRAIN DATA SET
###################################
## ASSUME row order is same for X_train (feature values in columns),
##                              y_train (activity map), 
##                          and subject_train (subject map)

##########################################################
## A) Read and Process X_*.txt, the feature values file ##
##########################################################
X <- read.table("./UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
## subset the 66 feature columns from X using the position vector
X_66 <- X[ , featurelist66]
## assign column names based on the names vector for the 66 features
names(X_66)=featurenames
# diagnostics
#        str(X_66) # 7352 x 66, correct
#        head(X_66, n=100) # has standardized feature names

## create record index for the feature value data
recTRACER <- as.data.frame(seq(1:nrow(X_66)))
names(recTRACER)=c("recTRACER")
#diagnostics
#        head(recTRACER, n=5)

## add recTRACER to X data
X_wID <- cbind( recTRACER , X_66 )
#diagnostics
#        str(X_wID) # 7352 x 67, as expected

###################################################################
## B) Read and Process y_train.txt, the activity map for X_*.txt ##
###################################################################
y <- read.table("./UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
names(y)<-c("activityNBR")
#diagnostics
#        str(y) # 7352 x 1, maps activity number to record of X_*
#        unique(y$activityNBR) #5 4 6 1 3 2

# add recTRACER to y_
y_wID <- cbind( recTRACER , y )
#diagnostics
#        str(y_wID) # 7352 x 2, as expected

# create descriptive activity column via merge to activity data frame
y_wID2 <- merge(y_wID, activity, by="activityNBR", all.x=TRUE)
## NOTE: merge will reorder the rows of y_*
#diagnostics
#        str(y_wID2) # 7352 x 3, as expected
#        head(y_wID2, n=5)

# order rows and columns
y_wID3 <- y_wID2[order(y_wID2$recTRACER), c("recTRACER", "activityNBR", "activityDESC")]
#diagnostics
#        str(y_wID3) # 7352 x 3, as expected
#        head(y_wID3,n=5)

########################################################################
## C) Read and Process subject_train.txt, the subject map for X_*.txt ##
########################################################################
subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
names(subject)<-c("subjectNBR")
# diagnostics
#        str(subject) # 7352 x 1, maps subject number to record of X_*
#        head(subject,n=5)
#        unique(subject$subjectNBR) # 21 subjects in training group
#1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30

# add recTRACER to subject Data
subject_wID <- cbind( recTRACER , subject )
#diagnostics
#        str(subject_wID) # 7352 x 2, as expected
#        head(subject_wID, n=5)


########################################
## D) create the FINAL TRAIN DATA SET ##
########################################
######  NOTES: ######
## there are 3 files
#    the X data (feature values), 
#    the y data (activity), and 
#    the subject number data
#    All have maintained the record order and have a recTRACER

## merge subject and activity, both have recTRACER in common
subj_act <- merge(subject_wID, y_wID3, all=TRUE)
#diagnostics
#        str(subj_act) # 7352 x 4, as expected

## merge subject/activity with the feature value data, 
#  both have recTRACER in common, record order maintained
traindata <- merge(subj_act, X_wID, all=TRUE)
# diagnostics
#        str(traindata) # 7352 x 70, as expected

# create a column for these data identifying them as the TRAIN data set
subjectgroup <- as.data.frame(rep("TRAIN", nrow(traindata)))
names(subjectgroup)=c("subjectgroup")
# diagnostic
#        str(subjectgroup) # 7352 x 1, as expected

traindatafinal=cbind(subjectgroup,traindata)
# diagnostics
#        str(traindatafinal) # 7352 x 71, as expected
#        summary(traindatafinal)
#        all(colSums(is.na(traindatafinal))==0) # no missing values
#        xtabs( ~ activityDESC, data=traindatafinal ) 
#        xtabs( ~ activityNBR + activityDESC, data=traindatafinal ) 
#        xtabs( ~ activityDESC + subjectNBR, data=traindatafinal ) 


################################
## TESTING GROUP DATA process ##
################################
# Files to read are in ./UCI HAR Dataset/test
# E) X_test.txt ( x 561, formats: +-n.nnnnnnne-00n), feature value data 
# F) y_test.txt ( x 1), maps activity number to each row of X_*.txt
# G) subject_test.txt ( x 1), maps subject number to each row of X_*.txt
# H) create the FINAL TEST DATA SET
################################
## ASSUME row order is same for X_test (feature values in columns),
##                              y_test (activity map), 
##                          and subject_test (subject map)

##########################################################
## E) Read and Process X_*.txt, the feature values file ##
##########################################################
X <- read.table("./UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
## subset the 66 feature columns from X using the position vector
X_66 <- X[ , featurelist66]
## assign column names based on the names vector for the 66 features
names(X_66)=featurenames
# diagnostics
#        str(X_66) # 2947 x 66, as expected
#        head(X_66, n=100) # has standardized feature names

## create record index for the feature value data
recTRACER <- as.data.frame(seq(1:nrow(X_66)))
names(recTRACER)=c("recTRACER")
# diagnostics
#        summary(recTRACER)
#        head(recTRACER, n=5)

## add recTRACER to X data
X_wID <- cbind( recTRACER , X_66 )
# diagnostics
#        str(X_wID) # 2947 x 67, as expected

##################################################################
## F) Read and Process y_test.txt, the activity map for X_*.txt ##
##################################################################
y <- read.table("./UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
names(y)<-c("activityNBR")
# diagnostics
#        str(y) # 2947 x 1, maps activity number to record of X_*
#        unique(y$activityNBR) #5 4 6 1 3 2

# add recTRACER to y_
y_wID <- cbind( recTRACER , y )
# diagnostics
#        str(y_wID) # 2947 x 2, as expected

# create descriptive activity column via merge to activity data frame
# ?merge
y_wID2 <- merge(y_wID, activity, by="activityNBR", all.x=TRUE)
## NOTE: merge will reorder the rows of y_*
# diagnostics
#        str(y_wID2) # 2947 x 3, as expected
#        head(y_wID2, n=5)

# order rows and columns
y_wID3 <- y_wID2[order(y_wID2$recTRACER), c("recTRACER", "activityNBR", "activityDESC")]
# diagnostics
#        str(y_wID3) # 2947 x 3, as expected
#        head(y_wID3,n=5)

#######################################################################
## G) Read and Process subject_test.txt, the subject map for X_*.txt ##
#######################################################################
subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
names(subject)<-c("subjectNBR")
# diagnostics
#        str(subject) # 2947 x 1, maps subject number to record of X_*
#        head(subject,n=5)
#        unique(subject$subjectNBR) # 9 subjects in testing group
        #2  4  9 10 12 13 18 20 24

# add recTRACER to subject Data
subject_wID <- cbind( recTRACER , subject )
#diagnostics
#        str(subject_wID) # 2947 x 2, as expected
#        head(subject_wID, n=5)

#######################################
## H) create the FINAL TEST DATA SET ##
#######################################
######  NOTES: ######
## there are 3 files
#    the X data (feature values), 
#    the y data (activity), and 
#    the subject number data
#    All have maintained the record order and have a recTRACER

## merge subject and activity, both have recTRACER in common
subj_act <- merge(subject_wID, y_wID3, all=TRUE)
# diagnostics
#        str(subj_act) # 2947 x 4, as expected

## merge subject/activity with the feature value data, 
#  both have recTRACER in common, record order maintained
testdata <- merge(subj_act, X_wID, all=TRUE)
# diagnostics
#        str(testdata) # 2947 x 70, as expected

# create a column for these data identifying them as the TEST data set
subjectgroup <- as.data.frame(rep("TEST", nrow(testdata)))
names(subjectgroup)=c("subjectgroup")
# diagnostics
#        str(subjectgroup) # 2947 x 1, as expected

testdatafinal=cbind(subjectgroup, testdata)
# diagnostics
#        str(testdatafinal) # 2947 x 71, as expected
#        summary(testdatafinal)
#        all(colSums(is.na(testdatafinal))==0) # no missing values
#        xtabs( ~ activityDESC, data=testdatafinal ) 
#        xtabs( ~ activityNBR + activityDESC, data=testdatafinal ) 
#        xtabs( ~ activityDESC + subjectNBR, data=testdatafinal ) 

################################################################
# I) Combine the TRAIN and TEST data into one Tidy Data Set    #
#    and write it out to the WD as a csv                       #
################################################################
# this is a simple row bind of the TRAIN and TEST data sets
str(traindatafinal) #7352 x 71
str(testdatafinal) #2947 x 71
tidydata1 <- rbind(traindatafinal,testdatafinal)
# diagnostics
#        str(tidydata1) # 10299 x 71, as expected
#        summary(tidydata1)
#        all(colSums(is.na(tidydata1))==0) # no missing values
#        xtabs( ~ subjectgroup + activityDESC, data=tidydata1 ) 
#        xtabs( ~ subjectgroup + subjectNBR, data=tidydata1 ) 
#        xtabs( ~ subjectgroup + activityDESC + subjectNBR, data=tidydata1 )
#        xtabs( ~ activityDESC + activityNBR, data=tidydata1)

## Write this tidy data 1 to the working directory as a csv
write.table(x=tidydata1, file="tidydata1.csv" , sep="," , row.names=FALSE)

############################################
## J) create tidy data 2 from tidy data 1 ##
##    and write it out as tab delim .txt  ##
############################################
## Read tidy data 1 back into R for the processing of column means
tidydata1 <- read.table(file="tidydata1.csv", header=TRUE, sep=",")
# diagnostics
#        str(tidydata1) # 10299 x 71, as expected
#        head(tidydata1, n=10)
#        summary(tidydata1)

## create tall/skinny version of tidydata1 using melt()
library(reshape2)
tidydata1MELT <- melt(tidydata1, 
                      id=c("subjectNBR","activityDESC","recTRACER"), 
                      measure.vars=featurenames)
# diagnotics
#        str(tidydata1MELT) # 679734 x 5 (10299 * 66 rows, as expected)

# create a new column that is combination of subject and activity
# USE pipe |, since _ is part of activityDESC
tidydata1MELT$subjectNBR_activityDESC <- 
        do.call(paste, c(tidydata1MELT[c("subjectNBR", "activityDESC")], sep = "|"))
# diagnotics
#        str(tidydata1MELT) #679734 x 6

# Use dcast() with the new column to get the mean calculation
tidydata2 <- dcast(tidydata1MELT, subjectNBR_activityDESC ~ variable, mean)
# diagnostics
#        str(tidydata2) # 180 x 67 (180 combinations of subject and activity)
#        head(tidydata2, n=10)

# Use melt() to create tall/skinny version of tidydata2
tidydata2MELT <- melt(tidydata2, id=c("subjectNBR_activityDESC"), measure.vars=featurenames)
# diagnostics
#        str(tidydata2MELT) #11880 x 3 (180 * 66 rows, as expected)
# make column names understandable
colnames(tidydata2MELT)[2]="featureDESCstandard"
colnames(tidydata2MELT)[3]="mean"
# diagnostics
#        str(tidydata2MELT) #11880 x 3
#        head(tidydata2MELT, n=10)
#        all(colSums(is.na(tidydata2MELT))==0) # no missing values

# tidydata2MELT appears to be what is needed for the tidy data 2 deliverable, 
# just need to split the first col

# based on stackoverflow, use colsplit() in reshape2, and with() in base
tidydata2MELT2<-with(tidydata2MELT, 
            cbind(colsplit(tidydata2MELT$subjectNBR_activityDESC, 
                           pattern = "\\|", 
                           names = c('subjectNBR', 'activityDESC')), 
                  featureDESCstandard, 
                  mean))
# diagnostics
#        str(tidydata2MELT2) # 11880 x 4
#        head(tidydata2MELT2,n=10)
#        tail(tidydata2MELT2,n=10)
#        unique(tidydata2MELT2$subjectNBR)

####################################################
## Spot check the calculation for some test cases ##
####################################################
testMELT2 <- tidydata2MELT2
#CASE 1
subset(x=testMELT2, subset=(subjectNBR==1 & activityDESC=="LAYING" & featureDESCstandard=="tBodyAccmeanX"),
       select=mean)
case1<-subset(x=tidydata1, 
              subset=(subjectNBR==1 & activityDESC=="LAYING"), 
              select=tBodyAccmeanX)
mean(case1$tBodyAccmeanX)
#CASE 2
subset(x=testMELT2, subset=(subjectNBR==1 & activityDESC=="LAYING" & featureDESCstandard=="tBodyAccstdX"),
       select=mean)
case2<-subset(x=tidydata1, 
              subset=(subjectNBR==1 & activityDESC=="LAYING"), 
              select=tBodyAccstdX)
mean(case2$tBodyAccstdX)
#CASE 3
subset(x=testMELT2, subset=(subjectNBR==9 & activityDESC=="LAYING" & featureDESCstandard=="fBodyBodyGyroJerkMagmean"),
       select=mean)
case3<-subset(x=tidydata1, 
              subset=(subjectNBR==9 & activityDESC=="LAYING"), 
              select=fBodyBodyGyroJerkMagmean)
mean(case3$fBodyBodyGyroJerkMagmean)
#CASE 4
subset(x=testMELT2, subset=(subjectNBR==9 & activityDESC=="LAYING" & featureDESCstandard=="fBodyBodyGyroJerkMagstd"),
       select=mean)
case4<-subset(x=tidydata1, 
              subset=(subjectNBR==9 & activityDESC=="LAYING"), 
              select=fBodyBodyGyroJerkMagstd)
mean(case4$fBodyBodyGyroJerkMagstd)

## passes test cases, tidydata2MELT2 is the final data needed for upload
## needs to be a tab delimited file with .txt extension to work in COURSERA

#####################################################################
##  write the tidydata2MELT2 out to the WD as a tab delimited file ##
#####################################################################
write.table(x=tidydata2MELT2, file="tidydata2.txt", sep="\t", row.names = FALSE)

# diagnostics
# read back in and check results
#tidydata2 <- read.table(file="tidydata2.txt", sep="\t", header = TRUE)
#str(tidydata2)

# no matter where you go there you are... :)
