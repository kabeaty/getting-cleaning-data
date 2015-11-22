# Read tables for training set and test set
training_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")

# Read tables for training labels and test labels
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")

# Read table for activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Join training set and test set vertically
joined_set <- rbind(training_set, test_set)

# Extract only mean and standard deviation measurements
joined_set <- joined_set[1:6]

# Join the training labels and test labels vertically
joined_labels <- rbind(train_labels, test_labels)

# Add numbers column to both in prep for merge
joined_set$numbers <- rownames(joined_set)
joined_labels$numbers <- rownames(joined_labels)

# Merge labels with joined set
merged_set_labels <- merge(joined_set, joined_labels, by.x="numbers", by.y="numbers")

# Add in activity labels to match up with activity numbers
merged_set_labels <- merge(merged_set_labels, activity_labels, by.x="V1.y", by.y="V1")

# Rearrange order of columns with new activity column first
merged_set_labels <- merged_set_labels[c(2,9,3,4,5,6,7,8)]

# Rename columns more descriptively
names(merged_set_labels)[names(merged_set_labels)=="V2.y"] <- "Activity"
names(merged_set_labels)[names(merged_set_labels)=="V1.x"] <- "tBodyAccMeanX"
names(merged_set_labels)[names(merged_set_labels)=="V2.x"] <- "tBodyAccMeanY"
names(merged_set_labels)[names(merged_set_labels)=="V3"] <- "tBodyAccMeanZ"
names(merged_set_labels)[names(merged_set_labels)=="V4"] <- "tBodyAccStdX"
names(merged_set_labels)[names(merged_set_labels)=="V5"] <- "tBodyAccStdY"
names(merged_set_labels)[names(merged_set_labels)=="V6"] <- "tBodyAccStdZ"

# Read tables for subject training and test files
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# merge subjects together, also by numbers column from row names
merged_subjects <- rbind(subject_train, subject_test)
merged_subjects$numbers <- rownames(merged_subjects)
merge_w_subjects <- merge(merged_set_labels, merged_subjects, by.x="numbers", by.y="numbers")
merge_w_subjects <- subset(merge_w_subjects, select=-numbers)

# Rename subjects column and reorder
names(merge_w_subjects)[names(merge_w_subjects)=="V1"] <- "Subject"
merge_w_subjects <- merge_w_subjects[c(8,1,2,3,4,5,6,7)]

# Function for getting averages by subject and activity
get_averages <- function(dataset) {
  avg_subject_activites <- data.frame(subject=character(),activity=character(),
  AvgTBodyAccMeanX=integer(), AvgTBodyAccMeanY=integer(),
  AvgTBodyAccMeanZ=integer(), AvgTBodyAccStdX=integer(),
  AvgTBodyAccStdY=integer(), AvgTBodyAccStdZ=integer())

  for (num in unique(dataset$Subject)) {
    for (activity in unique(dataset$Activity)) {
      subset_merge <- subset(dataset, Subject==num)
      subset_activity <- subset(subset_merge, Activity==activity)
      AvgTBodyAccMeanX <- mean(subset_activity[[3]], na.rm=TRUE)
      AvgTBodyAccMeanY <- mean(subset_activity[[4]], na.rm=TRUE)
      AvgTBodyAccMeanZ <- mean(subset_activity[[5]], na.rm=TRUE)
      AvgTBodyAccStdX <- mean(subset_activity[[6]], na.rm=TRUE)
      AvgTBodyAccStdY <- mean(subset_activity[[7]], na.rm=TRUE)
      AvgTBodyAccStdZ <- mean(subset_activity[[8]], na.rm=TRUE)
      avg_subject_activites <- as.data.frame(rbind(as.matrix(avg_subject_activites),
        c(num, activity, AvgTBodyAccMeanX, AvgTBodyAccMeanY, AvgTBodyAccMeanZ,
          AvgTBodyAccStdX, AvgTBodyAccStdY, AvgTBodyAccStdZ)))
    }
  }
  avg_subject_activites
}

# Run function to return data frame with averages by subject and activity
get_averages(merge_w_subjects)
