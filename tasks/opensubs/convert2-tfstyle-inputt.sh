#!/bin/bash
DATA_DIR=$1
OUT_DIR=$2
fname=$3

ENCODE_FILE="${OUT_DIR}/${fname}_encode"
DECODE_FILE="${OUT_DIR}/${fname}_decode"
# python parsing/DataUtils.py

echo "encode: ${ENCODE_FILE}"
echo "decode: ${DECODE_FILE}"
awk 'NR%3==1' ${DATA_DIR}/${fname} > "${ENCODE_FILE}"
awk 'NR%3==2' ${DATA_DIR}/${fname} > "${DECODE_FILE}"

echo 'sanity check (nothing should appear to be correct)'
grep -w "S:" $ENCODE_FILE
grep -w "W:" $DECODE_FILE

# Revmoing "U:" & "S:" at the beginning
awk 'NR%3==1' ${DATA_DIR}/${fname} | cut -c 4-  > ${ENCODE_FILE}
awk 'NR%3==2' ${DATA_DIR}/${fname} | cut -c 4-  > ${DECODE_FILE}


head -n 5 ${DATA_DIR}/${fname}
head -n 3 ${ENCODE_FILE}

head -n 5 ${DATA_DIR}/${fname}
head -n 3 ${DECODE_FILE}
