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

target_link_libraries(test_lib_platform test_main tf_core_lib)
target_link_libraries(test_lib test_main tf_core_lib)
target_link_libraries(test_lib_monitoring test_main tf_core_lib)

#add_custom_command(
#    TARGET test_lib_core 
#    POST_BUILD
#    COMMAND "${tensorflow_root_dir}/build/test_lib_core"
#    WORKING_DIRECTORY "${tensorflow_root_dir}/build"
#    COMMENT "Running test_lib_core check..."
#)

set(tf_core_framework_test_srcs_files
"common_runtime/buf_rendezvous_test.cc"
"common_runtime/collective_executor_mgr_test.cc"
"common_runtime/collective_param_resolver_local_test.cc"
"common_runtime/collective_rma_local_test.cc"
"common_runtime/device_resolver_local_test.cc"
"common_runtime/device_set_test.cc"
"common_runtime/optimization_registry_test.cc"
"common_runtime/pending_counts_test.cc"
"common_runtime/placer_test.cc"
"common_runtime/session_test.cc"
"example/feature_util_test.cc"
"framework/allocator_test.cc"
"framework/attr_value_util_test.cc"
"framework/bfloat16_test.cc"
"framework/cancellation_test.cc"
"framework/common_shape_fns_test.cc"
"framework/function_test.cc"
"framework/graph_def_util_test.cc"
"framework/kernel_def_builder_test.cc"
"framework/memory_types_test.cc"
"framework/node_def_builder_test.cc"
"framework/node_def_util_test.cc"
"framework/op_compatibility_test.cc"
"framework/op_def_builder_test.cc"
"framework/op_def_util_test.cc"
"framework/op_kernel_test.cc"
"framework/op_registration_test.cc"
"framework/partial_tensor_shape_test.cc"
"framework/rendezvous_test.cc"
"framework/resource_mgr_test.cc"
"framework/resource_op_kernel_test.cc"
"framework/shape_inference_test.cc"
"framework/shape_inference_testutil_test.cc"
"framework/tensor_shape_test.cc"
"framework/tensor_slice_test.cc"
"framework/tensor_test.cc"
"framework/tensor_util_test.cc"
"framework/tracking_allocator_test.cc"
"framework/types_test.cc"
"framework/unique_tensor_references_test.cc"
"framework/variant_op_registry_test.cc"
"framework/variant_test.cc"
"graph/algorithm_test.cc"
"graph/edgeset_test.cc"
"graph/graph_def_builder_test.cc"
"graph/graph_partition_test.cc"
"graph/graph_test.cc"
"graph/node_builder_test.cc"
"graph/optimizer_cse_test.cc"
"graph/subgraph_test.cc"
"graph/tensor_id_test.cc"
"graph/validate_test.cc"
"util/bcast_test.cc"
"util/command_line_flags_test.cc"
"util/device_name_utils_test.cc"
"util/equal_graph_def_test.cc"
"util/events_writer_test.cc"
"util/example_proto_fast_parsing_test.cc"
"util/example_proto_helper_test.cc"
"util/memmapped_file_system_test.cc"
"util/presized_cuckoo_map_test.cc"
"util/reffed_status_callback_test.cc"
"util/reporter_test.cc"
"util/saved_tensor_slice_util_test.cc"
"util/semver_test.cc"
"util/sparse/sparse_tensor_test.cc"
"util/stat_summarizer_test.cc"
"util/tensor_format_test.cc"
"util/tensor_slice_reader_test.cc"
"util/tensor_slice_set_test.cc"
"util/tensor_slice_util_test.cc"
"util/tensor_slice_writer_test.cc"
"util/work_sharder_test.cc"
)

set(tf_core_framework_test_srcs "")

foreach(file ${tf_core_framework_test_srcs_files})
    message(STATUS "${tensorflow_source_dir}/tensorflow/core/${file}") 
    list(APPEND tf_core_framework_test_srcs "${tensorflow_source_dir}/tensorflow/core/${file}")
endforeach(file ${})

add_executable(test_framework ${tf_core_framework_test_srcs})
target_link_libraries(test_framework test_main tf_core_framework)