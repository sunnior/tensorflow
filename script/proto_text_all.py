import os
import subprocess

source_dir = 'code'
protoc = 'build/tf_proto_text'
placeholder = 'code/tensorflow/tools/proto_text/placeholder.txt'

for root, _, filenames in os.walk(source_dir):
    for filename in filenames:
        if (filename.endswith(".proto")):
            filepath = os.path.join(root, filename)
            print(filepath)
            subprocess.call([protoc, 'gencode', 'code', placeholder, filepath])
