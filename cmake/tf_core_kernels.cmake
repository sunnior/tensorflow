file(GLOB_RECURSE tf_core_kernels_srcs
"${tensorflow_source_dir}/tensorflow/core/kernels/constant_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/no_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cast_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cast_op_impl_*.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/fill_functor.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/function_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/variable_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_op_sub.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_ops_common.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/relu_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/fake_quant_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/batch_util.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/control_flow_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_op_add_1.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_op_mul_1.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_op_neg.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_op_square.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_op_imag.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_op_complex.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/pack_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/unpack_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/dense_update_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/fifo_queue.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/quantize_and_dequantize_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/fifo_queu_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/identity_n_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/identity_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/matmul_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/queue_base.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/queue_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/sendrecv_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/session_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/shape_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/sequence_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/reduction_ops_max.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/reduction_ops_min.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/reduction_ops_common.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/transpose_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/aggregate_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/transpose_functor_cpu.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/ops_util.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/concat_lib_cpu.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/split_lib_cpu.cc"
 )
 
if (WIN32)
set_source_files_properties(
	"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_op_sub.cc"
	"${tensorflow_source_dir}/tensorflow/core/kernels/matmul_op.cc"
	PROPERTIES
	COMPILE_FLAGS "/bigobj"
)
endif (WIN32)

add_library(tf_core_kernels_obj OBJECT ${tf_core_kernels_srcs})
add_dependencies(tf_core_kernels_obj generate_proto_cc generate_proto_text)
