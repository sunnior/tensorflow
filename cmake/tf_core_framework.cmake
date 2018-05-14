file(GLOB_RECURSE tf_core_framework_srcs
    "${tensorflow_source_dir}/tensorflow/core/framework/*.h"
    "${tensorflow_source_dir}/tensorflow/core/framework/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/platform/variant_coding.h"
    "${tensorflow_source_dir}/tensorflow/core/platform/variant_coding.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/edgeset.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/edgeset.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/graph.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/graph.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/graph_def_builder.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/graph_def_builder.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/node_builder.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/node_builder.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/tensor_id.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/tensor_id.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/while_context.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/while_context.cc"
    "${tensorflow_source_dir}/tensorflow/core/util/*.h"
    "${tensorflow_source_dir}/tensorflow/core/util/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/session.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/session_factory.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/session_options.cc"
    #"${tensorflow_source_dir}/tensorflow/contrib/tensorboard/db/*.cc"
    #"${tensorflow_source_dir}/tensorflow/contrib/tensorboard/db/*.h"
    "${tensorflow_source_dir}/public/*.h"
)

file(GLOB_RECURSE tf_core_framework_exclude_srcs
    "${tensorflow_source_dir}/tensorflow/core/framework/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/framework/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/framework/*testutil.h"
    "${tensorflow_source_dir}/tensorflow/core/framework/*testutil.cc"
    "${tensorflow_source_dir}/tensorflow/core/framework/*main.cc"
    "${tensorflow_source_dir}/tensorflow/core/framework/resource_handle.cc"
    "${tensorflow_source_dir}/tensorflow/core/util/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/util/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/util/*main.cc"
    #"${tensorflow_source_dir}/tensorflow/contrib/tensorboard/db/*test*.cc"
    #"${tensorflow_source_dir}/tensorflow/contrib/tensorboard/db/loader.cc"
    #"${tensorflow_source_dir}/tensorflow/contrib/tensorboard/db/vacuum.cc"
)

list(REMOVE_ITEM tf_core_framework_srcs ${tf_core_framework_exclude_srcs})

add_library(tf_core_framework ${tf_core_framework_srcs})
target_link_libraries(tf_core_framework tf_core_lib)