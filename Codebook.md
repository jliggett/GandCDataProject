### Codebook for Getting and Cleaning Data Course Project
Describes the variables, data, and transformations performed to clean up the data

#### dataset used
Data acquired from 'Human Activity Recognition Using Smartphones Data Set'. Consists of activity data gathered by persons wearing Samsun S smartphones that tracked six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

#### input data
features.txt
activity_labels.txt
subject_train.txt
y_train.txt
X_train.txt
subject_test.txt
y_test.txt
X_test.txt

#### tranformations
input data are read in as the following
featNames
activityLab
subjectTrain
activityTrain
featuresTrain
subjectTest
activityTest
featuresTest

subjects in training and test are merged into subject
activities in training and test are merged into activity
features in training and test are merged into features

subjects, activities, features are then merged into one dataset
this dataset is then trimmed to only contain mean and stand deviation values
column names are updated to become more descriptive
tidy data set is then written to the working directory

#### output data
tidy.txt
