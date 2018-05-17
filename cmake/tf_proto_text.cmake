add_executable(tf_proto_text
    "${tensorflow_source_dir}/tensorflow/tools/proto_text/gen_proto_text_functions.cc"
    "${tensorflow_source_dir}/tensorflow/tools/proto_text/gen_proto_text_functions_lib.cc"    
)

target_link_libraries(tf_proto_text tf_core_lib)

set_target_properties(tf_proto_text
	PROPERTIES
	RUNTIME_OUTPUT_DIRECTORY_DEBUG "${tensorflow_root_dir}/build/tools"
	RUNTIME_OUTPUT_DIRECTORY_RELEASE "${tensorflow_root_dir}/build/tools"
)

add_custom_target(script2_gen_proto_text
    COMMAND python script/proto_text_all.py
    WORKING_DIRECTORY ${tensorflow_root_dir}
)

add_dependencies(script2_gen_proto_text tf_proto_text)

file(GLOB_RECURSE tf_proto_text_srcs 
    "${tensorflow_root_dir}/gencode/tensorflow/*pb_text.cc"
    "${tensorflow_root_dir}/gencode/tensorflow/*pb_text.h"
    "${tensorflow_root_dir}/gencode/tensorflow/*pb_text-impl.h"
    "${tensorflow_root_dir}/cmake/dummy.cc"
)

add_library(tf_proto_text_lib ${tf_proto_text_srcs})
add_dependencies(tf_proto_text_lib script2_gen_proto_text)
