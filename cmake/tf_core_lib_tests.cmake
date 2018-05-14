add_library(test_util_main 
    "${tensorflow_source_dir}/tensorflow/core/platform/test_main.cc"
    "${tensorflow_source_dir}/tensorflow/core/util/reporter.cc"
    "${tensorflow_source_dir}/tensorflow/core/platform/default/test_benchmark.cc"    
    "${tensorflow_source_dir}/tensorflow/core/platform/test.cc"    
)

target_link_libraries(test_util_main ${gtest_static_library})

file(GLOB_RECURSE tf_core_lib_test_srcs
    "${tensorflow_source_dir}/tensorflow/core/lib/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/lib/*test*.cc"
)

#seperate this test from lib test to avoid duplicate regestration
file (GLOB tf_core_lib_monitoring_test_srcs
    "${tensorflow_source_dir}/tensorflow/core/lib/monitoring/collection_registry_test.cc"
)

list(REMOVE_ITEM tf_core_lib_test_srcs ${tf_core_lib_monitoring_test_srcs})

file(GLOB tf_core_lib_test_platform_srcs
    "${tensorflow_source_dir}/tensorflow/core/platform/fingerprint_test.cc",
    "${tensorflow_source_dir}/tensorflow/core/platform/integral_types_test.cc",
    "${tensorflow_source_dir}/tensorflow/core/platform/logging_test.cc",
    "${tensorflow_source_dir}/tensorflow/core/platform/net_test.cc",
    "${tensorflow_source_dir}/tensorflow/core/platform/port_test.cc",
#for now disable profiler
#    "${tensorflow_source_dir}/tensorflow/core/platform/profile_utils/cpu_utils_test.cc",
    "${tensorflow_source_dir}/tensorflow/core/platform/stacktrace_handler_test.cc",
    "${tensorflow_source_dir}/tensorflow/core/platform/subprocess_test.cc",
)


if (WIN32)
file(GLOB tf_core_lib_test_platform_windows_srcs
    "${tensorflow_source_dir}/tensorflow/core/platform/windows/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/platform/windows/*test*.cc"
)
list(APPEND tf_core_lib_test_platform_srcs ${tf_core_lib_test_platform_windows_srcs})
else (WIN32)
file(GLOB tf_core_lib_test_platform_posix_srcs
    "${tensorflow_source_dir}/tensorflow/core/platform/posix/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/platform/posix/*test*.cc"
)
list(APPEND tf_core_lib_test_platform_srcs ${tf_core_lib_test_platform_posix_srcs})
endif(WIN32)

if (WIN32)
#vs compiler cannot pass this.
list(REMOVE_ITEM tf_core_lib_test_srcs "${tensorflow_source_dir}/tensorflow/core/lib/gtl/optional_test.cc")
endif (WIN32)


add_executable(test_lib ${tf_core_lib_test_srcs})
add_executable(test_lib_platform ${tf_core_lib_test_platform_srcs})
add_executable(test_lib_monitoring ${tf_core_lib_monitoring_test_srcs})

target_link_libraries(test_lib_platform test_util_main tf_core_lib)
target_link_libraries(test_lib test_util_main tf_core_lib)
target_link_libraries(test_lib_monitoring test_util_main tf_core_lib)