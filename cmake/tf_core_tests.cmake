add_library(test_main 
    "${tensorflow_source_dir}/tensorflow/core/platform/test_main.cc"
    "${tensorflow_source_dir}/tensorflow/core/util/reporter.cc"
    "${tensorflow_source_dir}/tensorflow/core/platform/default/test_benchmark.cc"    
)

target_link_libraries(test_main ${gtest_static_library})

file(GLOB tf_core_lib_core_test_srcs
    "${tensorflow_source_dir}/tensorflow/core/lib/core/*test*.h"
    "${tensorflow_source_dir}/tensorflow/core/lib/core/*test*.cc"
    "${tensorflow_source_dir}/tensorflow/core/lib/gtl/*test*.cc"
)

add_executable(test_lib_core ${tf_core_lib_core_test_srcs})

target_link_libraries(test_lib_core test_main tf_core_lib)

#add_custom_command(
#    TARGET test_lib_core 
#    POST_BUILD
#    COMMAND "${tensorflow_root_dir}/build/test_lib_core"
#    WORKING_DIRECTORY "${tensorflow_root_dir}/build"
#    COMMENT "Running test_lib_core check..."
#)