file(GLOB_RECURSE tf_core_ops_srcs
"${tensorflow_source_dir}/tensorflow/core/ops/array_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/logging_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/math_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/nn_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/data_flow_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/sendrecv_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/function_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/ops/no_op.cc"
)

add_library(tf_core_ops OBJECT ${tf_core_ops_srcs})