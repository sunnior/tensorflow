import os
import subprocess

source_dir = 'code'
protoc = 'build/tools/tf_proto_text'
placeholder = 'code/tensorflow/tools/proto_text/placeholder.txt'

if os.name == 'nt':
    protoc = protoc + '.exe'

for root, _, filenames in os.walk(source_dir):
    for filename in filenames:
        if filename.endswith(".proto"):
            filepath = os.path.join(root, filename)
            if os.name == 'nt':
                filepath = filepath.replace('\\', '/')

            time = os.path.getmtime(filepath)
            genccpath = 'gen' + filepath[:-6] + '.pb_text.cc'
            genhpath = 'gen' + filepath[:-6] + '.pb_text.h'
            genhimplpath = 'gen' + filepath[:-6] + '.pb_text-impl.h'
            ifneedrun=True
            if os.path.isfile(genccpath) and os.path.isfile(genhpath) and os.path.isfile(genhimplpath):
                cctime = os.path.getmtime(genccpath)
                htime = os.path.getmtime(genhpath)
                himpltime = os.path.getmtime(genhimplpath)
                #print(cctime, htime)
                if cctime > time and htime > time and himpltime > time:
                    ifneedrun=False
            if ifneedrun:
                print('generate proto text file: ', filepath)
                subprocess.call([protoc, 'gencode', 'code', placeholder, filepath])
