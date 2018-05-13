add_executable(tf_proto_text
    "${tensorflow_source_dir}/tensorflow/tools/proto_text/gen_proto_text_functions.cc"
    "${tensorflow_source_dir}/tensorflow/tools/proto_text/gen_proto_text_functions_lib.cc"    
)

target_link_libraries(tf_proto_text tf_core_lib)
