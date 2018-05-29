file(GLOB_RECURSE tf_core_kernels_srcs
"${tensorflow_source_dir}/tensorflow/core/kernels/constant_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/save_restore_v2_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/fill_functor.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/save_restore_tensor.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/string_join_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/save_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/variable_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/dense_update_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/identity_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/no_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/pack_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/concat_lib_cpu.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/conv_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/ops_util.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/deep_conv2d.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_op_add_1.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_ops_common.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/relu_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/function_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/sendrecv_ops.cc"
)

if (WIN32)
set_source_files_properties(
${tf_core_kernels_srcs}
PROPERTIES
COMPILE_FLAGS "/bigobj"
)
endif (WIN32)

add_library(tf_core_kernels_obj OBJECT ${tf_core_kernels_srcs})
add_dependencies(tf_core_kernels_obj generate_proto_cc generate_proto_text)
