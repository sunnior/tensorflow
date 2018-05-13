import os
import subprocess

source_dir = 'code/tensorflow'
protoc = 'external/protobuf/bin/protoc'

os.chdir('..')
for root, _, filenames in os.walk(source_dir):
    for filename in filenames:
        if (filename.endswith(".proto")):
            filepath = os.path.join(root, filename)
            subprocess.call([protoc, '-I=code', '--cpp_out=gencode', filepath])