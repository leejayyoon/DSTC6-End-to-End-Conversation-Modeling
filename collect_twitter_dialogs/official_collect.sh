#!/bin/bash

# target=official_account_names_for_dstc6.txt
target=diff_official-trial_account_names.txt
datetime=`date +"%Y-%m-%d_%H-%M-%S"`
python collect_twitter_dialogs.py -t $target -o ./stored_data -l ./official_collect_${datetime}.log 
