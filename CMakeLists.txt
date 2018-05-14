cmake_minimum_required(VERSION 3.5)

project(tensorflow C CXX)

#set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-conversion-null")
#set(CMAKE_BUILD_TYPE "Release")

set(tensorflow_root_dir ${CMAKE_CURRENT_SOURCE_DIR})
set(tensorflow_source_dir "${tensorflow_root_dir}/code")

include_directories(
    ${tensorflow_source_dir}
    "${tensorflow_root_dir}/gencode"
    "${tensorflow_root_dir}/external/eigen3/include"
    "${tensorflow_root_dir}/external/gtest/include"
    "${tensorflow_root_dir}/external/nsync/include"
    "${tensorflow_root_dir}/external/protobuf/include"
    "${tensorflow_root_dir}/external/zlib/include"
    "${tensorflow_root_dir}/external/farmhash/include"
)

if (WIN32)
set(static_lib_ext "lib")
else (WIN32)
set(static_lib_ext "a")

endif (WIN32)

set(gtest_static_library "${tensorflow_root_dir}/external/gtest/lib/libgtest.${static_lib_ext}")
set(nsync_static_library "${tensorflow_root_dir}/external/nsync/lib/libnsync.${static_lib_ext}")
set(protobuf_static_library "${tensorflow_root_dir}/external/protobuf/lib/libprotobuf.${static_lib_ext}")
set(zlib_static_library "${tensorflow_root_dir}/external/zlib/lib/libz.${static_lib_ext}")
set(farmhash_static_library "${tensorflow_root_dir}/external/farmhash/lib/libfarmhash.${static_lib_ext}")

include("cmake/tf_core_lib.cmake")
include("cmake/tf_core_framework.cmake")
include("cmake/tf_core_tests.cmake")
include("cmake/tf_proto_text.cmake")