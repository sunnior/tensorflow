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

            print(targetname)
            print(internal)
            print(bin_path)
            subprocess.call([bin_path, output_dir + targetname + '.h', output_dir + targetname + '.cc', internal, api_dir])
