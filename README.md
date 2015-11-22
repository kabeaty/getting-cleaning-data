## The data
A description of the data analyzed by the script in this repo can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ).

The data was collected from accelerometers from the Samsung Galaxy S smartphone.


## Getting a tidy data set from the data
The run_analysis.R script found in this repo can be used to return a tidy data set with the average of six of the accelerometer feature vector measurements for each of the six activities and each of the thirty training and test subjects.

The activities are described by the variables STANDING, WALKING, LAYING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS, and SITTING. The subjects are identified by their numbers from 1 to 30.

The six measurements that are averaged by subject and activity are those that measure the mean of the X, Y, and Z directions for body acceleration, and the standard deviation for the X, Y, and Z directions for body acceleration.

This script contains two functions. The first function, get_dataset, returns a data frame with 8 columns for Subject, Activity, and each of the six measurements detailed above. The second function, get_averages, takes that data frame returned by get_dataset and loops over it, returning the average for each measurement for each unique combination of subject and activity. This function also returns a data frame with 8 columns for Subject, Activity, and the associated average of each of the six measurements. This data frame has 180 rows, one row for each of the six activities for each of the 30 training and test subjects.


## Running the script
Before running the script to get the tidy data set, you'll need to have the Samsung data loaded into your working directory. Once the data is loaded in, the run_analysis.R script should be run in the working directory to return the tidy data set.
