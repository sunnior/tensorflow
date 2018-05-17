import os
import subprocess

binary_dir = '../build'
prefix = 'tf_cc_ops_gen_'
prefix_internal = 'tf_cc_ops_gen_internal_'
prefix_len = len(prefix)
prefix_internal_len = len(prefix_internal)

ext = ''
if os.name == 'nt':
	ext = '.exe'
ext_len = len(ext)

output_dir = 'tensorflow/cc/ops/'
api_dir = '../code/tensorflow/core/api_def/base_api'

os.chdir('gencode')
if os.path.isdir('tensorflow/cc/ops') == False:
	os.makedirs('tensorflow/cc/ops')

for root, _, filenames in os.walk(binary_dir):
    for filename in filenames:
        if filename.startswith(prefix) and filename.endswith(ext):
            bin_path = os.path.join(root, filename)
            if filename.startswith(prefix_internal):
                targetname = filename[prefix_internal_len:-ext_len]
                internal = '1'
            else:
                targetname = filename[prefix_len:-ext_len]
                internal = '0'

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
            #print(targetname)
            #print(internal)
            #print(bin_path)
            if ifneedrun:
                print('generate ops:', targetname)
                subprocess.call([bin_path, output_header, output_cc, internal, api_dir])