input_fname=$1
mv_dir=$2
echo 'input_fname' $input_fname
echo 'mv_dir' $mv_dir
f_enc=${input_fname}_encode
f_dec=${input_fname}_decode

python get_encode_decode_twitter.py -i $input_fname -e $f_enc -d $f_dec

cut -c 4- $f_enc > $mv_dir/$f_enc
cut -c 4- $f_dec > $mv_dir/$f_dec

echo '========full diaglogue========'
head -n 20 $input_fname
echo '========encoder========'
head -n 10 $mv_dir/$f_enc
echo '========decoder========'
head -n 10 $mv_dir/$f_dec

# rm $f_enc
# rm $f_dec