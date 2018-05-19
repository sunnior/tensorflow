file(GLOB_RECURSE tf_core_framework_srcs
    "${tensorflow_source_dir}/tensorflow/core/framework/*.h"
    "${tensorflow_source_dir}/tensorflow/core/framework/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/platform/variant_coding.h"
    "${tensorflow_source_dir}/tensorflow/core/platform/variant_coding.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/*.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/util/*.h"
    "${tensorflow_source_dir}/tensorflow/core/util/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/*.h"
    "${tensorflow_source_dir}/tensorflow/core/example/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/example/*.h"
    "${tensorflow_source_dir}/tensorflow/core/grappler/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/grappler/*.h"
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
    "${tensorflow_source_dir}/tensorflow/core/graph/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/graph/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/gpu/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/common_runtime/gpu/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/example/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/example/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/grappler/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/grappler/*test*.h"
    #"${tensorflow_source_dir}/tensorflow/contrib/tensorboard/db/*test*.cc"
    #"${tensorflow_source_dir}/tensorflow/contrib/tensorboard/db/loader.cc"
    #"${tensorflow_source_dir}/tensorflow/contrib/tensorboard/db/vacuum.cc"
)

set(tf_core_framework_runtime_registration_srcs
"${tensorflow_source_dir}/tensorflow/core/common_runtime/threadpool_device_factory.cc"
"${tensorflow_source_dir}/tensorflow/core/common_runtime/threadpool_device.cc"
"${tensorflow_source_dir}/tensorflow/core/common_runtime/threadpool_device.h"
"${tensorflow_source_dir}/tensorflow/core/common_runtime/direct_session.h"
"${tensorflow_source_dir}/tensorflow/core/common_runtime/direct_session.cc"
)

list(REMOVE_ITEM tf_core_framework_srcs ${tf_core_framework_exclude_srcs})
list(REMOVE_ITEM tf_core_framework_srcs ${tf_core_framework_runtime_registration_srcs})

add_library(tf_core_framework ${tf_core_framework_srcs})
add_dependencies(tf_core_framework generate_proto_cc generate_proto_text)
set(tf_core_framework_link ${tf_core_lib_link} "tf_proto_text_lib")

add_library(tf_core_framework_runtime_obj OBJECT ${tf_core_framework_runtime_registration_srcs})
add_dependencies(tf_core_framework_runtime_obj generate_proto_text)

