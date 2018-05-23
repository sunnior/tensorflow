file(GLOB_RECURSE tf_core_kernels_srcs
     "${tensorflow_source_dir}/tensorflow/core/kernels/*.h"
     "${tensorflow_source_dir}/tensorflow/core/kernels/*.cc"
)

file(GLOB_RECURSE tf_core_kernels_exclude_srcs
   "${tensorflow_source_dir}/tensorflow/core/kernels/*test*.h"
   "${tensorflow_source_dir}/tensorflow/core/kernels/*test*.cc"
   "${tensorflow_source_dir}/tensorflow/core/kernels/*testutil.h"
   "${tensorflow_source_dir}/tensorflow/core/kernels/*testutil.cc"
   "${tensorflow_source_dir}/tensorflow/core/kernels/*test_utils.h"
   "${tensorflow_source_dir}/tensorflow/core/kernels/*test_utils.cc"
   "${tensorflow_source_dir}/tensorflow/core/kernels/*main.cc"
   "${tensorflow_source_dir}/tensorflow/core/kernels/*.cu.cc"
   "${tensorflow_source_dir}/tensorflow/core/kernels/fuzzing/*"
   "${tensorflow_source_dir}/tensorflow/core/kernels/hexagon/*"
   "${tensorflow_source_dir}/tensorflow/core/kernels/remote_fused_graph_rewriter_transform*.cc"
)
list(REMOVE_ITEM tf_core_kernels_srcs ${tf_core_kernels_exclude_srcs})

if(WIN32)
  file(GLOB_RECURSE tf_core_kernels_windows_exclude_srcs
      # not working on windows yet
      "${tensorflow_source_dir}/tensorflow/core/kernels/neon/*"
      # not in core - those are loaded dynamically as dll
      "${tensorflow_source_dir}/tensorflow/contrib/nearest_neighbor/kernels/hyperplane_lsh_probes.cc"
      "${tensorflow_source_dir}/tensorflow/contrib/nearest_neighbor/ops/nearest_neighbor_ops.cc"
      "${tensorflow_source_dir}/tensorflow/contrib/resampler/kernels/resampler_ops.cc"
      "${tensorflow_source_dir}/tensorflow/contrib/rnn/kernels/blas_gemm.cc"
      "${tensorflow_source_dir}/tensorflow/contrib/rnn/kernels/gru_ops.cc"
      "${tensorflow_source_dir}/tensorflow/contrib/rnn/kernels/lstm_ops.cc"
      "${tensorflow_source_dir}/tensorflow/contrib/rnn/ops/gru_ops.cc"
      "${tensorflow_source_dir}/tensorflow/contrib/rnn/ops/lstm_ops.cc"
      "${tensorflow_source_dir}/tensorflow/contrib/seq2seq/kernels/beam_search_ops.cc"
      "${tensorflow_source_dir}/tensorflow/contrib/seq2seq/ops/beam_search_ops.cc"
      # temporarily disable nccl (nccl itself needs to be ported to windows first)
      "${tensorflow_source_dir}/tensorflow/contrib/nccl/kernels/nccl_manager.cc"
      "${tensorflow_source_dir}/tensorflow/contrib/nccl/kernels/nccl_ops.cc"
      "${tensorflow_source_dir}/tensorflow/contrib/nccl/ops/nccl_ops.cc"
  )
  list(REMOVE_ITEM tf_core_kernels_srcs ${tf_core_kernels_windows_exclude_srcs})
endif(WIN32)

file(GLOB_RECURSE tf_core_kernels_not_compile_srcs
"${tensorflow_source_dir}/tensorflow/core/kernels/*quantiz*.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/spectrogram*.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/lmdb_reader_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/encode_jpeg_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/extract_jpeg_shape_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/encode_png_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/decode_image_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/segment_reduction_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/summary_image_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/summary_kernels.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/sparse_dense_binary_op_shared.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_op_expm1.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/neon_depthwise_conv_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/regex_replace_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/string_to_hash_bucket_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/debug_ops.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/reduction_ops_mean.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/meta_support.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/data/sql/*.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/data/sql_dataset_ops.cc"
)
list(REMOVE_ITEM tf_core_kernels_srcs ${tf_core_kernels_not_compile_srcs})

if (WIN32)
set_source_files_properties(
	"${tensorflow_source_dir}/tensorflow/core/kernels/cwise_op_sub.cc"
	"${tensorflow_source_dir}/tensorflow/core/kernels/matmul_op.cc"
	"${tensorflow_source_dir}/tensorflow/core/kernels/spacetobatch_op.cc"
	PROPERTIES
	COMPILE_FLAGS "/bigobj"
)
endif (WIN32)

add_library(tf_core_kernels_obj OBJECT ${tf_core_kernels_srcs})
add_dependencies(tf_core_kernels_obj generate_proto_cc generate_proto_text)
