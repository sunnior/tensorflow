file(GLOB_RECURSE tf_core_kernels_srcs
"${tensorflow_source_dir}/tensorflow/core/kernels/constant_op.cc"
"${tensorflow_source_dir}/tensorflow/core/kernels/fill_functor.cc"
)

add_library(tf_core_kernels ${tf_core_kernels_srcs})