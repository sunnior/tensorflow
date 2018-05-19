

add_executable(test_framework_graph_partition 
"${tensorflow_source_dir}/tensorflow/core/graph/graph_partition_test.cc"
${tf_cc_objs}
)

target_link_libraries(test_framework_graph_partition 
${test_framework_link}
${tf_cc_link}
)

file(GLOB_RECURSE test_tf_cc_srcs
"${tensorflow_source_dir}/tensorflow/cc/*test*.h"
"${tensorflow_source_dir}/tensorflow/cc/*test*.cc"
)


file(GLOB test_tf_cc_exclude_srcs
"${tensorflow_source_dir}/tensorflow/cc/profiler/profiler_test.cc"
"${tensorflow_source_dir}/tensorflow/cc/tools/freeze_saved_model_test.cc"
"${tensorflow_source_dir}/tensorflow/cc/framework/cc_ops_test.cc"
"${tensorflow_source_dir}/tensorflow/cc/framework/cc_op_gen_test.cc"
"${tensorflow_source_dir}/tensorflow/cc/saved_model/loader_test.cc"
)

list(REMOVE_ITEM test_tf_cc_srcs ${test_tf_cc_exclude_srcs})

add_executable(test_tf_cc 
${test_tf_cc_srcs} 
${tf_cc_obj}
)

target_link_libraries(test_tf_cc ${test_framework_link} ${tf_cc_link})

add_executable(test_tf_loader
"${tensorflow_source_dir}/tensorflow/cc/saved_model/loader_test.cc"
${tf_cc_obj}
)

target_link_libraries(test_tf_loader ${test_framework_link} ${tf_cc_link})
