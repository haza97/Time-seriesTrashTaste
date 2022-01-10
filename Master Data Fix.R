library(dplyr)
library(tidyr)
library(zoo)
library(crqa)
library(nonlinearTseries)
library(TSA)
#fragmentlist = ["1","2","3","4","5","S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8"]
number <-  "S8"
leftframe <-  capture.output(cat("C:\\Users\\harol\\Desktop\\TrashTasteProject\\OpenPose\\", number, "\\left_dataframe.csv", sep = ""))
rightframe <-  capture.output(cat("C:\\Users\\harol\\Desktop\\TrashTasteProject\\OpenPose\\", number, "\\right_dataframe.csv", sep = ""))
left_df <- read.csv(leftframe)
right_df <- read.csv(rightframe)

#Fixing Mixed Data
x_Nose_left <- left_df$Nose
x_Nose_left <- as.numeric(gsub(".*[(]([^,]+)[,].*", "\\1", x_Nose_left))
#Missing Data
mean(complete.cases(x_Nose_left))
na.locf(x_Nose_left)
index<- 1:length(x_Nose_left)
plot(index, x_Nose_left)
left_df$x_Nose_left <- x_Nose_left

affected_rows<- subset(left_df, left_df$x_Nose_left > 700)
temp <- right_df
temp[temp$X %in% affected_rows$X, ] <- affected_rows

y_LW_right <- temp$LWrist
y_LW_right <- as.numeric(gsub(".*[ ]([^,]+)[)].*", "\\1", y_LW_right))
#Missing Data
mean(complete.cases(y_LW_right))
na.locf(y_LW_right)
y_LW_right <- 720-y_LW_right
index<- 1:length(y_LW_right)
plot(index, y_LW_right)

right_df <- temp
left_df$x_Nose_left <- NULL


y_LS_left <- left_df$LShoulder
y_LS_left <- as.numeric(gsub(".*[ ]([^,]+)[)].*", "\\1", y_LS_left))
#Missing Data
mean(complete.cases(y_LS_left))
na.locf(y_LS_left)
y_LS_left <- 720-y_LS_left
LS_diff_left = y_LS_left - lag( y_LS_left)
left_df$LS_diff <- LS_diff_left

y_RS_left <- left_df$RShoulder
y_RS_left <- as.numeric(gsub(".*[ ]([^,]+)[)].*", "\\1", y_RS_left))
#Missing Data
mean(complete.cases(y_RS_left))
na.locf(y_RS_left)
y_RS_left <- 720-y_RS_left
RS_diff_left = y_RS_left - lag( y_RS_left)
left_df$RS_diff <- RS_diff_left

y_LS_right <- right_df$LShoulder
y_LS_right <- as.numeric(gsub(".*[ ]([^,]+)[)].*", "\\1", y_LS_right))
#Missing Data
mean(complete.cases(y_LS_right))
na.locf(y_LS_right)
y_LS_right <- 720-y_LS_right
LS_diff_right = y_LS_right - lag( y_LS_right)
right_df$LS_diff <- LS_diff_right

y_RS_right <- right_df$RShoulder
y_RS_right <- as.numeric(gsub(".*[ ]([^,]+)[)].*", "\\1", y_RS_right))
#Missing Data
mean(complete.cases(y_RS_right))
na.locf(y_RS_right)
y_RS_right <- 720-y_RS_right
RS_diff_right = y_RS_right - lag( y_RS_right)
right_df$RS_diff <- RS_diff_right


write.csv(left_df,leftframe, row.names = TRUE)
write.csv(right_df,rightframe, row.names = TRUE)
