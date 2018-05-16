import os
import subprocess

source_dir = 'code'
protoc = 'external/protobuf/bin/protoc'

for root, _, filenames in os.walk(source_dir):
    for filename in filenames:
        if (filename.endswith(".proto")):
            filepath = os.path.join(root, filename)
            time = os.path.getmtime(filepath)
            genccpath = 'gen' + filepath[:-6] + '.pb.cc'
            genhpath = 'gen' + filepath[:-6] + '.pb.h'
            ifneedrun=True
            if os.path.isfile(genccpath) and os.path.isfile(genhpath):
                cctime = os.path.getmtime(genccpath)
                htime = os.path.getmtime(genhpath)
                #print(cctime, htime)
                if cctime > time and htime > time:
                    ifneedrun=False
            #print(time, filepath)
            if ifneedrun:
                subprocess.call([protoc, '-I=code', '--cpp_out=gencode', filepath])