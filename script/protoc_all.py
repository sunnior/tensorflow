import os
import subprocess

source_dir = 'code'
protoc = 'external/protobuf/bin/protoc'

for root, _, filenames in os.walk(source_dir):
    for filename in filenames:
        if (filename.endswith(".proto")):
            filepath = os.path.join(root, filename)
            print(filepath)
            subprocess.call([protoc, '-I=code', '--cpp_out=gencode', filepath])