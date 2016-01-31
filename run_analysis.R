#Course Project for Reading and Cleaning Data

#Set Path to Access all necessary files in the same working directory
setwd("C:/Users/Alan/Documents/Cleaning/Project/") 

dir() #Checking to see if the files are there

##First Objective: Merge Training and Test Data-sets to create one dataset

#Reading in training data from text file
x_train <- read.table("x_train.txt", sep="", stringsAsFactors = F, header = F)
#Reading in test data from text file
x_test <- read.table("x_test.txt", sep="", stringsAsFactors = F, header = F)

#Reading in patient identifiers for training data from text file
x_train_ids <- read.table("subject_train.txt", sep="", stringsAsFactors = F, header = F)
#Reading in patient identifiers for test data from text file
x_test_ids <- read.table("subject_test.txt", sep="", stringsAsFactors = F, header = F)

#Reading in activity labels for training data from text file
y_train <- read.table("y_train.txt", sep="", stringsAsFactors = F, header = F)
#Reading in activity labels for test data from text file
y_test <- read.table("y_test.txt", sep="", stringsAsFactors = F, header = F)

#Column bind training and test pariticpant id's and activity labels to each dataset
x_train <- cbind(x_train_ids, y_train, x_train)
x_test <- cbind(x_test_ids, y_test, x_test)

#Merge training and test datasets
merged_df = rbind(x_train, x_test)


##Second Objective: Extract only the measurement with "mean" and "std"

#Create, import, and concatonate column labels
columnname <- c("Id", "ActivityCode") #First and Second columns
#Import existing lables for other columns
x_features <- read.table("features.txt", sep="", stringsAsFactors = F, header = F)
#Concatonate everything together
columnname <- c(columnname, x_features[, 2])
#Apply column labels to the dataset
colnames(merged_df) <- columnname 

#Find location of columns with "mean" and "std"
cmean <- grep("mean()", columnname, ignore.case = FALSE, value = FALSE, fixed = TRUE)
cstd <- grep("std()", columnname,ignore.case = FALSE, value = FALSE, fixed = TRUE)
#Creating objects with location for id and activity code
cid <- grep("id", columnname, ignore.case = TRUE, value = FALSE)
cactivity <- grep("activity", columnname, ignore.case = TRUE, value = FALSE)
#Concatonating all the column locations together
clocations <- c(cid, cactivity, cmean, cstd)
clocations <- sort(clocations, decreasing = FALSE)

#Subsetting out desired columns with "mean" and "std"
sub_df <- merged_df[, clocations]


##Third Objective: use descriptive activity names to name activities in the dataset

#Coercing existing activity to codes to factor and applying labels
sub_df$ActivityCode <- factor(sub_df$ActivityCode, labels=c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying"))
#Checking to see values have been coerced and labeled
attributes(sub_df$ActivityCode)

##Fourt Objective: Appropriately Label dataset with descriptive variable names

#Removing hyphens and parentheses
names(sub_df) <- gsub("-", "", names(sub_df),) #removing all hyphens
names(sub_df) <- gsub("\\(\\)", "", names(sub_df)) #removing all parentheses (meta-character)

#Function to convert all capital letters to lower case 
makelowercase <- function(x, y, z) {
        for (i in seq_along(y)) {  
                first <- y[i] #y is desired character vector of upper case letters
                second <- z[i] #x is desired character vector of lower case letters
                names(x) <- gsub(first, second, names(x))
        }
        x
}

upper <- LETTERS #Vector of all capital letters
lower <- letters #Vector of all lower case letters

#Apply function to create new df with all lower case letters in variable names
tidy_df <- makelowercase(x = sub_df, y = upper, z = lower)


#Fifth Objective: Create second tidy dataset with average of each variable, 
#for each activity, for each subject

##Use dplyr to group data by id and activity and then apply mean function to all variables
library(dplyr)
second_tidy_df <- tidy_df%>% 
        group_by(id, activitycode)%>% 
        summarise_each(funs(mean))

#Converting data back to normal data frame
second_tidy_df <- data.frame(second_tidy_df)

#Double checking dataframe
str(second_tidy_df)
#Looks Good! 

#Writing submission to text file
write.table(second_tidy_df, file = "tidy_data_set.txt", row.names = FALSE)

