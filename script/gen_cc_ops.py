import os
import subprocess

output_dir = 'tensorflow/cc/ops/'
api_dir = '../code/tensorflow/core/api_def/base_api'
binary_dir = '../build/tools'

prefix = 'tf_cc_ops_gen_'
prefix_internal = prefix + 'internal_'
prefix_len = len(prefix)
prefix_internal_len = len(prefix_internal)

suffix = ''
if os.name == 'nt':
	suffix = '.exe'
suffix_len = len(suffix)

os.chdir('gencode')
if os.path.isdir('tensorflow/cc/ops') == False:
	os.makedirs('tensorflow/cc/ops')

for root, _, filenames in os.walk(binary_dir):
    for filename in filenames:
        if filename.startswith(prefix) and filename.endswith(suffix):
            bin_path = os.path.join(root, filename)
            if filename.startswith(prefix_internal):
                targetname = filename[prefix_internal_len:]
                internal = '1'
            else:
                targetname = filename[prefix_len:]
                internal = '0'
            
            if suffix_len != 0:
                targetname = targetname[:-suffix_len]
            
            time = os.path.getmtime(bin_path)
            ifneedrun = True
            output_header = output_dir + targetname + '.h'
            output_cc = output_dir + targetname + '.cc'
            ifneedrun = True
            ifneedrun = True
            if os.path.isfile(output_header) and os.path.isfile(output_cc):
                header_time = os.path.getmtime(output_header)
                cc_time = os.path.getmtime(output_cc)
                if header_time > time and cc_time > time:
                    ifneedrun = False

            if ifneedrun:
                print('generate ops:', targetname)
                subprocess.call([bin_path, output_header, output_cc, internal, api_dir])