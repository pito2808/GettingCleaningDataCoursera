## 1.
# download file
file_url <- ("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

download.file(file_url,destfile="./getdata-projectfiles-UCI HAR Dataset.zip")

# unzip file

unzip("./getdata-projectfiles-UCI HAR Dataset.zip")

uc_dir <- "./UCI HAR Dataset"

# X
dftestX <- read.table("UCI HAR Dataset/test/x_test.txt")
dftrainX <- read.table("UCI HAR Dataset/train/x_train.txt")


# add columns y_ to dataset
#dftestXY <- cbind(dftestX,dftestY)
#dftrainXY <- cbind(dftrainX,dftrainY)

# appending rows
DFX <- rbind(dftrainX,dftestX)


# names dftest and dftrain
# extract features to vectors
features<-  read.table ("UCI HAR Dataset/features.txt")
v_features <- as.character(features[["V2"]])

v_features_ms <- grep("\\b-mean()\\b|-std()",v_features)

## 2.
# apply vectores to names
#DFX1 <- setNames (DFX, v_features)

# extract columnes values with grep
#DFX1_std_mean <- DFX1[,grep("\\b-mean()\\b|-std()", names(DFX1))]

DFX1_sm <-DFX[,grep("\\b-mean()\\b|-std()",v_features)]

## 3.
# Y
dftestY <- read.table("UCI HAR Dataset/test/y_test.txt")
dftrainY <- read.table("UCI HAR Dataset/train/y_train.txt")

# appending rows
DFY <- rbind(dftrainY,dftestY)

# append column activity to DFX
DFXY <- cbind(DFX1_sm,DFY)

names(DFXY)[67] <- "activity"

# read table activity names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",
                       stringsAsFactor = FALSE)
activity_name <- function(x) {
    re <- activity_labels[x,2]
    return(re)
}

#DFTT <- DFXY
DFXY1 <- transform(DFXY, activity = activity_name(activity)) 


##4.
v_features_ms <- v_features[grep("\\b-mean()\\b|-std()",v_features)]

v_features_msa<- (append(v_features_ms,'activity'))
# apply vectores to names
DFXY1 <- setNames (DFXY1, v_features_msa)

## 5.

dftestU <- read.table("UCI HAR Dataset/test/subject_test.txt")
dftrainU <- read.table("UCI HAR Dataset/train/subject_train.txt")

# appending rows
DFU <- rbind(dftrainU,dftestU)
# append column User to DFX
DFXYU <- cbind(DFU,DFXY1)

names(DFXYU)[1] <- "volunteers"

#DFXYU1 <- DFXYU
#DFXYU1$volunteers <- as.character(DFXYU$volunteers)

DFXYU1 <- aggregate(DFXYU[2:67], by = DFXYU[c("volunteers","activity")], FUN = mean)

final <- DFXYU1[order(DFXYU1$volunteers),]

head(final, n = 100)
