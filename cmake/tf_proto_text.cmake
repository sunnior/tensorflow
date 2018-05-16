add_executable(tf_proto_text
    "${tensorflow_source_dir}/tensorflow/tools/proto_text/gen_proto_text_functions.cc"
    "${tensorflow_source_dir}/tensorflow/tools/proto_text/gen_proto_text_functions_lib.cc"    
)

target_link_libraries(tf_proto_text tf_core_lib)

add_custom_target(tf_gen_proto_text
    COMMAND python script/proto_text_all.py
    WORKING_DIRECTORY ${tensorflow_root_dir}
)

add_dependencies(tf_gen_proto_text tf_proto_text)

file(GLOB_RECURSE tf_proto_text_srcs 
    "${tensorflow_root_dir}/gencode/tensorflow/*pb_text.cc"
    "${tensorflow_root_dir}/gencode/tensorflow/*pb_text.h"
    "${tensorflow_root_dir}/gencode/tensorflow/*pb_text-impl.h"
)

add_library(tf_proto_text_lib ${tf_proto_text_srcs})
add_dependencies(tf_proto_text_lib tf_gen_proto_text)
