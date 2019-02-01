
This code book describes the  the data set "tidydataset.txt", that is created by running the "run_analysis.R" script.

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data set can be read by executing the following command:
dataset <- read.table("tidydataset.txt", header=TRUE)

The resulting data frame is composed of 180 observations (rows) and 88 variables (columns).

There is a total of 30 observations for each subject studied. In total, 6 subjects were observed.

* Column 1 "subject": is a numeric identifier of the subject who performed the activity

* Column 2 "activity_type": identifies the type of activity performed by the subjects. It's a factor variable and there are 6 possible levels: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS.

* Columns 3 to 88: these are all numeric variables and represent measurements taken using the accelerometer and gyroscope 3-axial when the subject moved. Only the measurements on the mean and standard deviation have been included.