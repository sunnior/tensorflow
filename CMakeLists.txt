cmake_minimum_required(VERSION 3.5)

project(tensorflow C CXX)

#set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_CXX_STANDARD 14)
#set(CMAKE_BUILD_TYPE "Release")
add_definitions(-D__AVX2__ -D__AVX__)

if (WIN32)
add_definitions(-DPLATFORM_WINDOWS -DTF_WIN_STATIC_LIBRARY -DCOMPILER_MSVC -DNOMINMAX)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
#4716: must return a value
#4267, 4244: data type narrowing
#4800: forcing value to bool
#4576: a parenthesized type followed by an initializer list is a non-standard explicit type conversion syntax
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4716 /wd4267 /wd4244 /wd4800 /wd4576")
else (WIN32)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-conversion-null")
endif (WIN32)

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

include("cmake/tf_proto_cc.cmake")
include("cmake/tf_core_lib.cmake")
set(tf_core_lib_link tf_core_lib tf_proto_cc_lib)
include("cmake/tf_core_lib_tests.cmake")

include("cmake/tf_proto_text.cmake")
include("cmake/tf_core_framework.cmake")
include("cmake/tf_core_ops.cmake")
include("cmake/tf_core_kernels.cmake")
set(tf_core_framework_link tf_core_framework tf_proto_text_lib ${tf_core_lib_link})
include("cmake/tf_core_framework_tests.cmake")

include("cmake/tf_cc_ops.cmake")
include("cmake/tf_cc.cmake")
#include("cmake/tf_higher_level_tests.cmake")
