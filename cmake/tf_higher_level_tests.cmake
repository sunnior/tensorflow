add_executable(test_framework_graph_partition 
"${tensorflow_source_dir}/tensorflow/core/graph/graph_partition_test.cc"
$<TARGET_OBJECTS:tf_core_ops>
$<TARGET_OBJECTS:tf_core_kernels>
$<TARGET_OBJECTS:tf_core_framework_runtime_registration>
)

target_link_libraries(test_framework_graph_partition test_util_main test_util_framework tf_core_framework tf_cc_ops)

file(GLOB_RECURSE test_tf_cc_srcs
"${tensorflow_source_dir}/tensorflow/cc/*test*.h"
"${tensorflow_source_dir}/tensorflow/cc/*test*.cc"
)

file(GLOB test_tf_cc_exclude_srcs
"${tensorflow_source_dir}/tensorflow/cc/profiler/profiler_test.cc"
"${tensorflow_source_dir}/tensorflow/cc/tools/freeze_saved_model_test.cc"
"${tensorflow_source_dir}/tensorflow/cc/framework/cc_ops_test.cc"
"${tensorflow_source_dir}/tensorflow/cc/framework/cc_op_gen_test.cc"
)

list(REMOVE_ITEM test_tf_cc_srcs ${test_tf_cc_exclude_srcs})

add_executable(test_tf_cc 
${test_tf_cc_srcs} 
$<TARGET_OBJECTS:tf_core_ops>
$<TARGET_OBJECTS:tf_core_kernels>
$<TARGET_OBJECTS:tf_core_framework_runtime_registration>
$<TARGET_OBJECTS:tf_cc_grads>
)

target_link_libraries(test_tf_cc test_util_main test_util_framework tf_core_framework tf_cc_ops)