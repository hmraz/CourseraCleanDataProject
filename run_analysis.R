library(reshape)
library(reshape2)

setwd("C:/WORK/Data Science Specialization/R Programming/UCI HAR Dataset")

### Merging the Training and Test Sets
x_train<-read.table("./train/x_train.txt")
x_test<-read.table("./test/x_test.txt")
x<-rbind(x_train,x_test)

featureLabels<-read.table("./features.txt")

y_train<-read.table("./train/y_train.txt")   ## The activity they are doing -- replace numbers with text from the readme
y_test<-read.table("./test/y_test.txt")
y<-rbind(y_train,y_test)
colnames(y)<-"Activity"

activity_labels<-read.table("./activity_labels.txt")

subject_train<-read.table("./train/subject_train.txt")
subject_test<-read.table("./test/subject_test.txt")
subject<-rbind(subject_train,subject_test)
colnames(subject)<-"subject_id"

##  Extracting measurements with mean and std_dev readings

colnames(x)<-featureLabels$V2

meanIndices<-grep("mean",featureLabels$V2)
stdIndices<-grep("std",featureLabels$V2)
wantedColumns<-sort(append(meanIndices,stdIndices))
xMeanStd<-x[,wantedColumns]


## Combining the data and subject + activity id's to a single data frame

datasetMeanStd<-cbind(subject,y,xMeanStd)

## Using melt/cast to reshape and tidy the data with mean per unique subject+activity

meltedData <- melt(datasetMeanStd, id.vars=c("subject_id","Activity"))
finalDataTidyData<- cast(data=meltedData, fun=mean)

## Replacing the activity numbers with their real labels/meanings
i<-1
for(i in 1:6)
{  yLabeled<-(gsub(i,activity_labels$V2[i],finalDataTidyData$Activity))
   finalDataTidyData$Activity<-yLabeled}

## Finally Writing the tidy data frame as a .txt file!
write.table(finalDataTidyData,file="./finalDataTidyData.txt") 
