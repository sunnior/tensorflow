#################################################
# tf_proto_text lib
#################################################

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

add_custom_target(generate_proto_text
    COMMAND python script/gen_proto_text.py
    WORKING_DIRECTORY ${tensorflow_root_dir}
)

add_dependencies(generate_proto_text tf_proto_text)

set(tf_proto_text_srcs 
    ${PROTO_TEXT_SRCS}
    ${PROTO_TEXT_HDRS}
    ${PROTO_TEXT_IMPL_HDRS}
)

add_library(tf_proto_text_lib ${tf_proto_text_srcs})
add_dependencies(tf_proto_text_lib generate_proto_text)
