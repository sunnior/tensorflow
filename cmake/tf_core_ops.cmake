if (FALSE)
file(GLOB_RECURSE tf_core_ops_srcs
"${tensorflow_source_dir}/tensorflow/core/ops/array_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/array_grad.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/logging_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/math_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/math_grad.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/nn_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/data_flow_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/control_flow_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/sendrecv_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/function_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/functional_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/no_op.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/state_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/parsing_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/string_ops.cc"
)
endif (FALSE)
file(GLOB tf_core_ops_srcs
"${tensorflow_source_dir}/tensorflow/core/ops/*.cc"
)

file(GLOB tf_core_ops_test_srcs
"${tensorflow_source_dir}/tensorflow/core/ops/*test*.cc"
)

list(REMOVE_ITEM tf_core_ops_srcs ${tf_core_ops_test_srcs})

add_library(tf_core_ops_obj OBJECT ${tf_core_ops_srcs})
add_dependencies(tf_core_ops_obj generate_proto_cc)