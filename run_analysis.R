## 1. Merges the training and the test sets to create one data set.

# create data dir
if ( !file.exists("../data")) {
    dir.create("../data")
}
# download file
file_url <- ("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

download.file(file_url,destfile="../data/getdata-projectfiles-UCI HAR Dataset.zip")

# unzip file
current_wd <- getwd()
setwd("../data")
unzip("getdata-projectfiles-UCI HAR Dataset.zip")
setwd(current_wd)

# X
dftestX <- read.table("../data/UCI HAR Dataset/test/x_test.txt")
dftrainX <- read.table("../data/UCI HAR Dataset/train/x_train.txt")

# appending rows
DFX <- rbind(dftrainX,dftestX)


# read features.txt to vectors
# names dftest and dftrain
# extract features to vectors
features<-  read.table("../data/UCI HAR Dataset/features.txt",
                       stringsAsFactors = FALSE)


# extract features with occurence b-mean() and b-std()
#  but not meanFreq()
v_features_ms <- grep("\\b-mean()\\b|-std()",features[["V2"]])

## 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement.

# extract columnes values with grep
DFX1_sm <-DFX[,grep("\\b-mean()\\b|-std()",features[["V2"]])]

## 3.Uses descriptive activity names to name the activities 
## in the data set
# Y contains labels

dftestY <- read.table("../data/UCI HAR Dataset/test/y_test.txt")
dftrainY <- read.table("../data/UCI HAR Dataset/train/y_train.txt")

# appending rows
DFY <- rbind(dftrainY,dftestY)

# append column activity to DFX
DFXY <- cbind(DFX1_sm,DFY)

# name column 67 which contains activity
names(DFXY)[67] <- "activity"

# read table activity names
activity_labels <- read.table("../data/UCI HAR Dataset/activity_labels.txt",
                       stringsAsFactor = FALSE)

# function return activity label to full description
activity_name <- function(x) {
    re <- activity_labels[x,2]
    return(re)
}

# replace each cell on column activity by full description
DFXY1 <- transform(DFXY, activity = activity_name(activity)) 


##4.Appropriately labels the data set with descriptive variable names. 

# create vector with all labels
#v_features_ms <- v_features[grep("\\b-mean()\\b|-std()",v_features)]
#v_features <- features[["V2"]]
#v_features_ms <- features[grep("\\b-mean()\\b|-std()",v_features)]

# create vector with all labels
v_features_ms <- features[grep("\\b-mean()\\b|-std()",features$V2),][[2]]
v_features_msa <- (append(v_features_ms,'activity'))

# apply vectores to names
DFXY1 <- setNames (DFXY1, v_features_msa)


## 5.Creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject.

dftestU <- read.table("../data/UCI HAR Dataset/test/subject_test.txt")
dftrainU <- read.table("../data/UCI HAR Dataset/train/subject_train.txt")

# appending rows
DFU <- rbind(dftrainU,dftestU)

# append column User to DFX
DFXYU <- cbind(DFU,DFXY1)

# name the new column as volunteers
names(DFXYU)[1] <- "volunteers"

#DFXYU1 <- DFXYU
#DFXYU1$volunteers <- as.character(DFXYU$volunteers)

# aggregate to calculate the average by volunteers and activity
# first column and last col contains volunteers and activity
# so we skip it.

DFXYU1 <- aggregate(DFXYU[2:67], 
                    by = DFXYU[c("volunteers","activity")], 
                    FUN = mean)

# we order result by volunteers number
DFXYU1_volunteers <- DFXYU1[order(DFXYU1$volunteers),]

write.table(DFXYU1_volunteers, 
            file = "tidydata.txt",
            sep = ",",
            col.names = colnames(DFXYU1_volunteers))

head(DFXYU1_volunteers , n = 15)
