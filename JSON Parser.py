import json
import os
import pandas as pd
fragmentlist = ["1","2","3","4","5","S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8"]
for number in fragmentlist:
    path_to_json = f"C:\\Users\\harol\\Desktop\\TrashTasteProject\\OpenPose\\{number}\\keypoints\\"

    def parse_json(json_list):
        number_of_keyps = len(json_list)/3
        if number_of_keyps != 25:
            return "NA"
        else:
            print("all 25 keypoints detected")

        # Turn the JSON output into a dictionary per body part
        keypoint_list = ["Nose", "Neck", "RShoulder", "RElbow", "RWrist", "LShoulder", "LElbow", "LWrist", "MidHip", "RHip", "RKnee", "RAnkle",
                        "LHip", "LKnee", "LAnkle", "REye", "LEye", "REar", "LEar", "LBigToe", "LSmallToe", "LHeel", "RBigToe", "RSmallToe", "RHeel", "Background"]
        bodyparts = {}
        for number in range(1, 26):
            scores = json_list[(number-1)*3: number*3]
            bodyparts[keypoint_list[number-1]] = scores

        present_bodyparts = bodyparts.copy()
        for keypoint in keypoint_list[:25]:
            if present_bodyparts.get(keypoint)[2] == 0:
                present_bodyparts.pop(keypoint)
        bodypartslist = []
        for key in present_bodyparts:
            bodypartslist.append((present_bodyparts[key][0], present_bodyparts[key][1]))

        df_body = pd.DataFrame([bodypartslist], columns = present_bodyparts.keys())
        
        return df_body

        
    keypoint_list = ["Nose", "Neck", "RShoulder", "RElbow", "RWrist", "LShoulder", "LElbow", "LWrist", "MidHip", "RHip", "RKnee", "RAnkle",
                    "LHip", "LKnee", "LAnkle", "REye", "LEye", "REar", "LEar", "LBigToe", "LSmallToe", "LHeel", "RBigToe", "RSmallToe", "RHeel", "Background"]

    json_files = [pos_json for pos_json in os.listdir(
        path_to_json) if pos_json.endswith('.json')]
    print('Found: ', len(json_files), 'json keypoint frame files')

    left_dataframe = pd.DataFrame(columns=keypoint_list)
    right_dataframe = pd.DataFrame(columns=keypoint_list)

    for index, file in enumerate(json_files):
        temp_df = json.load(open(path_to_json+file))
        leftlist = temp_df['people'][0]["pose_keypoints_2d"]
        rightlist = temp_df['people'][1]["pose_keypoints_2d"]
        left_dataframe = left_dataframe.append(parse_json(leftlist), ignore_index = True)
        right_dataframe = right_dataframe.append(parse_json(rightlist), ignore_index=True)

    #Save dataframes as csv
    right_dataframe.to_csv(path_or_buf=f"C:\\Users\\harol\\Desktop\\TrashTasteProject\\OpenPose\\{number}\\left_dataframe.csv", index=True)
    left_dataframe.to_csv(path_or_buf=f"C:\\Users\\harol\\Desktop\\TrashTasteProject\\OpenPose\\{number}\\right_dataframe.csv", index=True)
    print(f"Written to {number}")
