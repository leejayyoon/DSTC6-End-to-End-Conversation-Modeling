import io
import argparse

# example
# python get_encode_decode_twitter.py -i twitter_official_data_dev500.txt -o encode.txt -d decode.txt
argparser = argparse.ArgumentParser()
argparser.add_argument("-i", "--input_filename", required=True)
argparser.add_argument("-e", "--filename_encode", required=True)
argparser.add_argument("-d", "--filename_decode", required=True)
args = argparser.parse_args()


def rm_and_replace(_str, rm_prefix, rp_prefix, rp_term):
  str_list= _str.split()
  new_list=[]
  for x in str_list:
    if x.startswith(rm_prefix):
      continue
    elif x[:2]==rp_prefix:
      new_list.append(rp_term)
    else:
      new_list.append(x)
  return " ".join(new_list)

def remove_string_with_prefix(_str, prefix): 
  #this is still problematic since it does not work if the string
  # because it doesn't work ifthe # is in between # find such pattern
  return " ".join(filter(lambda x:x[0]!=prefix, _str.split()))

def replace_string_with_prefix(_str, prefix, replace):
  return " ".join(filter(lambda x:x[0]!=prefix, _str.split()))

with io.open(args.input_filename, encoding='utf8') as input_file, \
  io.open(args.filename_encode, encoding='utf8', mode='w') as enc_file, \
  io.open(args.filename_decode, encoding='utf8', mode='w') as dec_file:
  count=0
  line2 = input_file.next()
  for in_line in input_file:    
    count+=1
    line1=line2
    line2=in_line
    # print 'count', count 
    # print line1.strip('\n')
    # print line2.strip('\n')
    if len(line1.strip())>0 and len(line2.strip())>0:
      assert( len(line1.strip())!=0 and len(line2.strip())!=0 ) 
      ## remove and replace at the same time. @user to __mention__ 
      line1=rm_and_replace(line1, "#", ":@", "__mention__")
      line2=rm_and_replace(line2, "#", ":@", "__mention__")
      ## operation remove and replace separately. # and @user to __mention__
      # line1 = remove_string_with_prefix(line1, "#")
      # line2 = remove_string_with_prefix(line2, "#")         
      # line1 = replace_string_with_prefix(line1, "@", "__mention__")
      # line2 = replace_string_with_prefix(line2, "@", "__mention__")                 
      enc_file.write(line1+"\n")
      dec_file.write(line2+"\n")
    if not line1 and not line2: # when both lines are empty. (ending condition)  
      print('count:'+str(count))
      break
