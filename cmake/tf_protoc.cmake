add_custom_target(script1_gen_protoc
    COMMAND python script/protoc_all.py
    WORKING_DIRECTORY ${tensorflow_root_dir}
)

file(GLOB_RECURSE tf_protoc_srcs 
    "${tensorflow_root_dir}/gencode/tensorflow/*pb.cc"
    "${tensorflow_root_dir}/gencode/tensorflow/*pb.h"
    "${tensorflow_source_dir}/tensorflow/core/lib/strings/proto_text_util.cc"
)

message(STATUS "!!!!!!!!!!!!!${tf_protoc_srcs}")
add_library(tf_protoc ${tf_protoc_srcs})
add_dependencies(tf_protoc script1_gen_protoc)
