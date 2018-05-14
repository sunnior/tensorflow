file(GLOB_RECURSE tf_core_lib_srcs
    "${tensorflow_source_dir}/tensorflow/core/lib/*.h"
    "${tensorflow_source_dir}/tensorflow/core/lib/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/public/*.h"
)

file(GLOB tf_core_platform_srcs
    "${tensorflow_source_dir}/tensorflow/core/platform/*.h"
    "${tensorflow_source_dir}/tensorflow/core/platform/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/platform/default/*.h"
    "${tensorflow_source_dir}/tensorflow/core/platform/default/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/framework/resource_handle.h"
    "${tensorflow_source_dir}/tensorflow/core/framework/resource_handle.cc")
if (NOT tensorflow_ENABLE_GPU)
  file(GLOB tf_core_platform_gpu_srcs
      "${tensorflow_source_dir}/tensorflow/core/platform/cuda_libdevice_path.*"
      "${tensorflow_source_dir}/tensorflow/core/platform/default/cuda_libdevice_path.*")
  list(REMOVE_ITEM tf_core_platform_srcs ${tf_core_platform_gpu_srcs})
else()
  file(GLOB tf_core_platform_srcs_exclude
      "${tensorflow_source_dir}/tensorflow/core/platform/default/device_tracer.cc")
  list(REMOVE_ITEM tf_core_platform_srcs ${tf_core_platform_srcs_exclude})
endif()

file(GLOB tf_core_platform_exclude_srcs
  "${tensorflow_source_dir}/tensorflow/core/platform/variant_coding.cc")
list(REMOVE_ITEM tf_core_platform_srcs ${tf_core_platform_exclude_srcs})

list(APPEND tf_core_lib_srcs ${tf_core_platform_srcs})

if(UNIX)
  file(GLOB tf_core_platform_posix_srcs
      "${tensorflow_source_dir}/tensorflow/core/platform/posix/*.h"
      "${tensorflow_source_dir}/tensorflow/core/platform/posix/*.cc"
  )
  list(APPEND tf_core_lib_srcs ${tf_core_platform_posix_srcs})
endif(UNIX)

if(WIN32)
  file(GLOB tf_core_platform_windows_srcs
      "${tensorflow_source_dir}/tensorflow/core/platform/windows/*.h"
      "${tensorflow_source_dir}/tensorflow/core/platform/windows/*.cc"
      "${tensorflow_source_dir}/tensorflow/core/platform/posix/error.h"
      "${tensorflow_source_dir}/tensorflow/core/platform/posix/error.cc"
  )
  list(APPEND tf_core_lib_srcs ${tf_core_platform_windows_srcs})
endif(WIN32)

file(GLOB_RECURSE tf_core_lib_test_srcs
    "${tensorflow_source_dir}/tensorflow/core/lib/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/lib/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/platform/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/platform/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/public/*test*.h"
)
list(REMOVE_ITEM tf_core_lib_srcs ${tf_core_lib_test_srcs})

add_library(tf_core_lib STATIC ${tf_core_lib_srcs})

file(GLOB_RECURSE tf_protoc_srcs 
    "${tensorflow_root_dir}/gencode/tensorflow/*.cc"
    "${tensorflow_source_dir}/tensorflow/core/lib/strings/proto_text_util.cc"
)

add_library(tf_protoc ${tf_protoc_srcs})

set(external_static_library
"gtest/lib/libgtest"
"nsync/lib/libnsync"
"protobuf/lib/libprotobuf"
"zlib/lib/libz"
)
 
if (WIN32)
set(static_lib_ext "lib")
else (WIN32)
set(static_lib_ext "a")
#for now I didn't compile windows version
list(APPEND external_static_library "farmhash/lib/libfarmhash")
endif (WIN32)

target_link_libraries(tf_core_lib tf_protoc)

foreach(lib ${external_static_library})
    target_link_libraries(tf_core_lib debug "${tensorflow_root_dir}/external/${lib}d.${static_lib_ext}")
    target_link_libraries(tf_core_lib optimized "${tensorflow_root_dir}/external/${lib}.${static_lib_ext}")
endforeach(lib ${})

if (NOT WIN32)
find_package (Threads)
target_link_libraries(tf_core_lib ${CMAKE_THREAD_LIBS_INIT} "dl")
endif (NOT WIN32)
