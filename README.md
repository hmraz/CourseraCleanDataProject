CourseraCleanDataProject
========================
This is description of the Project for the Coursera course on Getting and Cleaning Data.
The run_analysis.R file works as follows:

1. First the test and training files are read in and appended together generating a total of 10299 observations (rows)
2. The activity and variable labels are also read for use within the script
3. The measurements/readings that have std or mean are then selected from the 561 original measurements. This results in 79 
matches. The occurence of mean or std at any place within the variable name was chosen a match (including meanFreq).
4. The measurements were then binded with the subject id and activity name creating 81 columns.
5. Melt/cast was used to reshape the data and determine the mean for each unique subject - activity pair. The result is 180
rows (30 observations x 6 activities).
6. Finally the tidy data was written to a .txt file. 
