# README File for Course Project: Getting and Cleaning Data
## Data Science Specialization

The accompanying files for this github repository include the following: (1) a codebook ("Codebook.txt") and a R script ("run_analysis.R"")

**Codebook**

The codebook is a text file that contains detailed information on the data and variables
that were used in the process of analytic file creation.

* Original data source and measures
* Variables extracted for the analysis
* Modified variable names with an explanation of the acronyms that are necessary for the intepretation of these measures
* Step by step guide for analytic file creation process

**R Script**

The R script contains a program that imports and combines various component tables from the Samsung dataset and then subsets to specific mean and standard deviation feature vectors that are calculated by subject id for each physical activity. For the program to function, all of the component text files containing subject ids, physical activity codes, main feature vectors, and feature labels have to be used. 

The following files must be located in the working directory: 

* X_train.txt 
* y_train.txt 
* subject_train.txt 
* X_test.txt 
* y_test.txt 
* subject_test.txt
* features.txt    

The program is divided into five portions that are explicated below.

* The first portion of the program imports and assembles the training and test datasets and then merges them together.
* The second portion extracts only the measurements on the mean and standard deviations for each main feature vector.
* The third potion appropriate labels for the physical activity code variable with activity codes that provided in the "activity_labels.txt" file.
* The fourth portion modifies and labels the variable names with descriptive strings using several different acronyms that are delineated in the codebook. The original names are provided in the "features.txt" file.
* The fifth portion creates a second tidy dataset using the dataframe created in the previous step, where the means for the average and standard deviation feature vectors are calculated by subject id for each physical activity. The final dataframe is outputted into a text file as "tidy_data_set.txt".