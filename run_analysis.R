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

# Merge the joined training and test sets with training and test labels by row
merged_set_labels <- merge(joined_set, joined_labels, by.x="row.names")

# Merge in activity labels
merged_set_labels <- merge(merged_set_labels, activity_labels, by.x="Row.names", by.y="V1")

# Rearrange order of columns with new activity column first
merged_set_labels <- merged_set_labels[c(8,1,2,3,4,5,6,7)]

# Subset out the less-descriptive activity column
merged_set_labels <- subset(merged_set_labels, select=-Row.names)

# Rename columns more descriptively
names(merged_set_labels)[names(merged_set_labels)=="V2.y"] <- "Activity"
names(merged_set_labels)[names(merged_set_labels)=="V1"] <- "tBodyAcc-mean()-X"
names(merged_set_labels)[names(merged_set_labels)=="V2.x"] <- "tBodyAcc-mean()-Y"
names(merged_set_labels)[names(merged_set_labels)=="V3"] <- "tBodyAcc-mean()-Z"
names(merged_set_labels)[names(merged_set_labels)=="V4"] <- "tBodyAcc-std()-X"
names(merged_set_labels)[names(merged_set_labels)=="V5"] <- "tBodyAcc-std()-Y"
names(merged_set_labels)[names(merged_set_labels)=="V6"] <- "tBodyAcc-std()-Z"
