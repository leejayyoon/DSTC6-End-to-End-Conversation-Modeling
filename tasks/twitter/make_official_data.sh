#!/bin/bash

# you can change the directory path according to the location of stored data
# stored_data=../../collect_twitter_dialogs/official_stored_data
stored_data=../../collect_twitter_dialogs/stored_data
stored_prefx="stored_"
# you need to download tweet ID info to specify the data sets
idfile=official_begin_end_ids.json
idlink=https://www.dropbox.com/s/8lmpu5dfw2hmpys/official_begin_end_ids.json.gz
echo downloading begin/end IDs for extracting data
## JY: commented out
# wget $idlink
# gunzip -f ${idfile}.gz

# extract train and dev sets
echo extracting training set
./extract_official_twitter_dialogs.py --data-dir $stored_data --id-file $idfile -t "${stored_prefx}official_account_names_train.txt" -o twitter_official_data_train.txt

echo extracting development set
./extract_official_twitter_dialogs.py --data-dir $stored_data --id-file $idfile -t "${stored_prefx}official_account_names_dev.txt" -o twitter_official_data_dev.txt

#JY added
echo extracting actual test set
./extract_official_twitter_dialogs.py --data-dir $stored_data --id-file $idfile -t "${stored_prefx}official_account_names_test.txt" -o twitter_official_data_test.txt

# extract 500 samples from dev set randomly for tentative evaluation
echo extracting subset of dev set # test set ids are partof dev set :(
./utils/sample_dialogs.py twitter_official_data_dev.txt 500 > twitter_official_data_dev500.txt

# echo done

# echo checking data size
# ./utils/check_dialogs.py twitter_official_data_train.txt twitter_official_data_dev.txt
./utils/check_dialogs.py twitter_official_data_dev.txt twitter_official_data_test.txt


# --- train set ---
# n_dialogs: 677541 (31.09 % difference from reference: 888201)
# n_utters: 1634085 (32.02 % difference from reference: 2157389)
# n_words: 30302740 (32.24 % difference from reference: 40073702)
# --- dev set ---
# n_dialogs: 82581 (30.18 % difference from reference: 107506)
# n_utters: 201427 (30.19 % difference from reference: 262228)
# n_words: 3758266 (30.40 % difference from reference: 4900743)
# --- test set ---
# n_dialogs: 63475 (69.37 % difference from reference: 107506)
# n_utters: 152287 (72.19 % difference from reference: 262228)
