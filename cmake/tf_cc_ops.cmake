file(GLOB tf_cc_ops_gen_srcs
"${tensorflow_source_dir}/tensorflow/cc/framework/cc_op_gen.cc"
"${tensorflow_source_dir}/tensorflow/cc/framework/cc_op_gen.h"
"${tensorflow_source_dir}/tensorflow/cc/framework/cc_op_gen_main.cc"
)

add_library(tf_cc_ops_gen ${tf_cc_ops_gen_srcs})
target_link_libraries(tf_cc_ops_gen tf_core_framework)

file(GLOB tf_cc_ops_srcs
"${tensorflow_source_dir}/tensorflow/cc/ops/*.cc"
"${tensorflow_root_dir}/gencode/tensorflow/cc/ops/*.cc"
)

file(GLOB tf_cc_ops_tests_srcs
"${tensorflow_source_dir}/tensorflow/cc/ops/*test*.cc"
)

list(REMOVE_ITEM tf_cc_ops_srcs ${tf_cc_ops_tests_srcs})

add_library(tf_cc_ops ${tf_cc_ops_srcs})
target_link_libraries(tf_cc_ops tf_cc)

set(tf_cc_ops_gen_targets
"array_ops"
"audio_ops"
"candidate_sampling_ops"
"control_flow_ops"
"data_flow_ops"
"image_ops"
"io_ops"
"linalg_ops"
"logging_ops"
"lookup_ops"
"manip_ops"
"math_ops"
"nn_ops"
"no_op"
"parsing_ops"
"random_ops"
"sparse_ops"
"state_ops"
"string_ops"
"training_ops"
#"user_ops"
)

set(tf_cc_ops_gen_internal_targets
"sendrecv_ops"
)

foreach(target ${tf_cc_ops_gen_targets})
add_executable(tf_cc_ops_gen_${target}
"${tensorflow_source_dir}/tensorflow/core/ops/${target}.cc"
)
target_link_libraries(tf_cc_ops_gen_${target} tf_cc_ops_gen)
endforeach(target ${})

foreach(target ${tf_cc_ops_gen_internal_targets})
add_executable(tf_cc_ops_gen_internal_${target}
"${tensorflow_source_dir}/tensorflow/core/ops/${target}.cc"
)
target_link_libraries(tf_cc_ops_gen_internal_${target} tf_cc_ops_gen)
endforeach(target ${})
