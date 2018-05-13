add_library(test_main 
    "${tensorflow_source_dir}/tensorflow/core/platform/test_main.cc"
    "${tensorflow_source_dir}/tensorflow/core/util/reporter.cc"
    "${tensorflow_source_dir}/tensorflow/core/platform/default/test_benchmark.cc"    
    "${tensorflow_source_dir}/tensorflow/core/platform/test.cc"    
)

target_link_libraries(test_main ${gtest_static_library})

file(GLOB_RECURSE tf_core_lib_test_srcs
    "${tensorflow_source_dir}/tensorflow/core/lib/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/lib/*test*.cc"
)

file(GLOB tf_core_lib_test_platform_srcs
    "${tensorflow_source_dir}/tensorflow/core/platform/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/platform/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/platform/default/*test*.cc"
)

#list(APPEND tf_core_lib_test_srcs ${tf_core_lib_test_platform_srcs})

if (WIN32)
file(GLOB tf_core_lib_test_platform_windows_srcs
    "${tensorflow_source_dir}/tensorflow/core/platform/windows/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/platform/windows/*test*.cc"
)
list(APPEND tf_core_lib_test_srcs ${tf_core_lib_test_platform_windows_srcs})
else (WIN32)
file(GLOB tf_core_lib_test_platform_posix_srcs
    "${tensorflow_source_dir}/tensorflow/core/platform/posix/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/platform/posix/*test*.cc"
)
list(APPEND tf_core_lib_test_srcs ${tf_core_lib_test_platform_posix_srcs})
endif(WIN32)


add_executable(test_lib ${tf_core_lib_test_srcs})
target_link_libraries(test_lib test_main tf_core_lib)



#add_custom_command(
#    TARGET test_lib_core 
#    POST_BUILD
#    COMMAND "${tensorflow_root_dir}/build/test_lib_core"
#    WORKING_DIRECTORY "${tensorflow_root_dir}/build"
#    COMMENT "Running test_lib_core check..."
#)