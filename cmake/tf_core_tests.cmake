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

add_executable(test_lib ${tf_core_lib_test_srcs})

target_link_libraries(test_lib test_main tf_core_lib)

#add_custom_command(
#    TARGET test_lib_core 
#    POST_BUILD
#    COMMAND "${tensorflow_root_dir}/build/test_lib_core"
#    WORKING_DIRECTORY "${tensorflow_root_dir}/build"
#    COMMENT "Running test_lib_core check..."
#)