# This R script does the following:
# 1)  Merges the training and the test sets to create one data set.
# 2)  Extracts only the measurements on the mean and standard deviation for each 
#     measurement. 
# 3)  Uses descriptive activity names to name the activities in the data set.
# 4)  Appropriately labels the data set with descriptive activity names. 
# 5)  Creates a second, independent tidy data set with the average of each 
#     variable for each activity and each subject. 

# The data linked to from the course website represent data collected from the 
# accelerometers from the Samsung Galaxy S smartphone. A full description is 
# available at the site where the data was obtained:   
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# The data for the project is located at:  
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# options
options(stringsAsFactors=FALSE, show.signif.stars = FALSE)
options(digits=7)  # needed for knitr to display correct digits
# R version and Package version
sessionInfo()
  
# read the label, training and test data sets

#####################################################
# set working directory to location of label files
old.wd <- setwd("./UCI HAR Dataset")

# read label files
filenames <- list.files(pattern="*.txt")
ldf1 <- lapply(filenames[1:2], read.table)
names(ldf1) <- filenames[1:2]

# return to original working directory
setwd(old.wd)

#####################################################
# set working directory to location of training files
old.wd <- setwd("./UCI HAR Dataset/train")

# read files and combine into a large dataset
filenames <- list.files(pattern="*.txt")
ldf2 <- lapply(filenames, read.table)
names(ldf2) <- filenames

# return to original working directory
setwd(old.wd)


#####################################################
# set working directory to location of test files
old.wd <- setwd("./UCI HAR Dataset/test")

# read files and combine into a large dataset
filenames <- list.files(pattern="*.txt")
ldf3 <- lapply(filenames, read.table)
names(ldf3) <- filenames

# return to original working directory
setwd(old.wd)


# find the feature names that consists of means or standard deviations
# regexpr returns a "-1" if "mean" or "std" is not found in the text
ldf1[[2]][,3] <- with(ldf1[[2]], !(regexpr("mean", V2, ignore.case=FALSE)<0 & 
                                     regexpr("std", V2, ignore.case=FALSE)<0 ))

# features that are mean or standard deviation
feat <- subset(ldf1[["features.txt"]], V3==TRUE)

# Extracts only the measurements on the mean and standard deviation for each 
#     measurement.
if(dim(ldf2[["X_train.txt"]])[2] != dim(feat)[1]) 
  ldf2[["X_train.txt"]] <- subset(ldf2[["X_train.txt"]], select=feat[,1])

if(dim(ldf3[["X_test.txt"]])[2] != dim(feat)[1]) 
  ldf3[["X_test.txt"]] <- subset(ldf3[["X_test.txt"]], select=feat[,1])


# combine the training and test data
tidyset <- do.call(cbind, mapply(rbind, ldf2, ldf3))

# replace column names to be appropriate tidy names
#   feature names were changed to eliminate any "," "-" or "()"
names(tidyset) <- c("Subject", gsub(",", "", 
                                    gsub("-", ".", 
                                         gsub("\\(", "",
                                              gsub("\\)", "", 
                                                   feat[,2])))), "Activity")

# Add descriptive activity names to name the activities in the data set.
tidyset$Activity <- with(tidyset, factor(Activity, labels=ldf1[[1]]$V2))

# write the tidyset as a csv file
write.csv(tidyset, "tidyset.csv", row.names=FALSE)

# write the tidyset as a txt file
write.table(tidyset, "tidyset.txt", sep = "\t", row.names=FALSE)



########################################################################
# Creates a second, independent tidy data set with the average of each 
#     variable for each activity and each subject.

# test of code
# formula <- as.formula(paste(names(tidyset)[2], " ~ Subject + Activity"))
# aggregate(formula, data=tidyset, FUN="mean")

temp <- lapply(2:(dim(tidyset)[2]-1), function(xx) {
  formula <- as.formula(paste(names(tidyset)[xx], " ~ Subject + Activity"))
  t1 <- aggregate(formula, data=tidyset, FUN="mean")
  if(xx==2) return(t1)
  return(subset(t1, select=3))
})

# create dataset by concatenate columns
tidyset2 <- do.call(cbind, temp)

# write the summary data frame tidyset2 as csv file
write.csv(tidyset2, "tidyset2.csv", row.names=FALSE)

