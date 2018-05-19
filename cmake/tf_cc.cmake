file(GLOB tf_cc_srcs
"${tensorflow_source_dir}/tensorflow/cc/framework/*.cc"
"${tensorflow_source_dir}/tensorflow/cc/framework/*.h"
"${tensorflow_source_dir}/tensorflow/cc/saved_model/*.cc"
"${tensorflow_source_dir}/tensorflow/cc/saved_model/*.h"
"${tensorflow_source_dir}/tensorflow/cc/training/*.cc"
"${tensorflow_source_dir}/tensorflow/cc/training/*.h"
"${tensorflow_source_dir}/tensorflow/cc/client/client_session.cc"
"${tensorflow_source_dir}/tensorflow/cc/client/client_session.h"
)

file(GLOB tf_cc_exclude_srcs
"${tensorflow_source_dir}/tensorflow/cc/framework/cc_op_gen.cc"
"${tensorflow_source_dir}/tensorflow/cc/framework/cc_op_gen.h"
"${tensorflow_source_dir}/tensorflow/cc/framework/cc_op_gen_main.cc"
"${tensorflow_source_dir}/tensorflow/cc/framework/*test*.cc"
"${tensorflow_source_dir}/tensorflow/cc/framework/*test*.h"
"${tensorflow_source_dir}/tensorflow/cc/saved_model/*test*.cc"
"${tensorflow_source_dir}/tensorflow/cc/saved_model/*test*.h"
"${tensorflow_source_dir}/tensorflow/cc/training/*test*.cc"
"${tensorflow_source_dir}/tensorflow/cc/training/*test*.h"
"${tensorflow_source_dir}/tensorflow/cc/gradients/*test*.cc"
"${tensorflow_source_dir}/tensorflow/cc/gradients/*test*.h"
)

file(GLOB tf_cc_grads_srcs
"${tensorflow_source_dir}/tensorflow/cc/gradients/*.cc"
"${tensorflow_source_dir}/tensorflow/cc/gradients/*.h"
)

file(GLOB tf_cc_grads_exclude_srcs
"${tensorflow_source_dir}/tensorflow/cc/gradients/*test*.cc"
"${tensorflow_source_dir}/tensorflow/cc/gradients/*test*.h"
)

list(REMOVE_ITEM tf_cc_srcs ${tf_cc_exclude_srcs})
list(REMOVE_ITEM tf_cc_grads_srcs ${tf_cc_grads_exclude_srcs})
add_library(tf_cc_lib ${tf_cc_srcs})
add_library(tf_cc_grads_obj OBJECT ${tf_cc_grads_srcs})
add_dependencies(tf_cc_lib generate_proto_cc generate_proto_text)