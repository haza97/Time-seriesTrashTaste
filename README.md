# Time-seriesTrashTaste
This is the repo for the paper Behavioral Synchrony and Emotional Excitement <br/>
Replicating this experiment would take quite some time and storage space, and would be done as follows: <br/>
All video files are too large to upload to GitHub, but can be found on [this google drive](https://drive.google.com/drive/folders/1MbY4JR7duoqRbc8X90nZo-JpHpGkQZnx?usp=sharing) <br/>
Apply the code in OpenPose_Trashtaste.ipynb to all video fragments, which results into a JSON file for each video. These can then be ran through the JSON Parser.py to be turned into a .csv file including the coordinates for each keypointfor each frame of each video. Applying Master Data Fix.rmd to all of these csv files will impute missing data, and calculate the rates of change for the required keypoints. This updates the existing .csv files, which are the input for Cross Correlation & Cross Recurrence.rmd to generate the graphs and table in the paper.
