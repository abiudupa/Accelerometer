# 1. Merging  the training and test sets into one data set.

#Read training
trainX <- read.table("./data/train/X_train.txt")
trainY <- read.table("./data/train/y_train.txt")
trainS <- read.table("./data/train/subject_train.txt")

#Read test
testX <- read.table("./data/test/X_test.txt")
testY <- read.table("./data/test/y_test.txt") 
testS <- read.table("./data/test/subject_test.txt")

#Combine train and test
combineX <- rbind(trainX, testX)
combineY <- rbind(trainY, testY)
combineS <- rbind(trainS, testS)


#2. Extracts based on the mean and standard deviation for each measurement. 

f <- read.table("./data/features.txt")
num <- grep("mean\\(\\)|std\\(\\)", f[, 2])
combineX <- combineX[, num]
name <-colnames(combineX)

#Replace mean with Mean and std with Std
name <- gsub("\\.+mean\\.+", name, replacement="Mean")
name <- gsub("\\.+std\\.+",  name, replacement="Std")

#Remove - and ()
name <- gsub("\\.-\\.+",  name, replacement="")
name <- gsub("\\(\\)",  f[num, 2], replacement="")
colnames(combineX) <-name



# 3. Descriptive activity names to name the activities

activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityY <- activity[combineY[, 1], 2]
combineY[, 1] <- activityY
name(combineY) <- "activity"


#4. Appropriately label with descriptive activity names. 

#Combine into final
name(combineS) <- "subject"
final <- cbind(combineS, combineY, combineX)

#write final into combine.txt
write.table(final, "combine.txt")


#5. Tidy data set with the average of each variable for each activity and each subject. 

#Initialize variables
r <- 1
s <- length(table(combineS)) # 30
a <- dim(activity)[1]
f <- dim(final)[2]
tidy <- as.data.frame(matrix(NA, nrow=s*a, ncol=f))
colnames(tidy) <- colnames(final)

#Calculate average
for(i in 1:s) {
  for(j in 1:a) {
    tidy[r, 1] <- sort(unique(combineS)[, 1])[i]
    tidy[r, 2] <- activity[j, 2]
    p <- i == final$subject
    q <- activity[j, 2] == final$activity
    tidy[r, 3:f] <- colMeans(final[p&q, 3:f])
    r <- r + 1
  }
}

#Write result into tidy.txt
write.table(result, "tidy.txt")

