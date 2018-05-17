add_library(test_util_framework
    "${tensorflow_source_dir}/tensorflow/core/framework/shape_inference_testutil.cc"
    "${tensorflow_source_dir}/tensorflow/core/framework/function_testlib.cc"
    "${tensorflow_source_dir}/tensorflow/core/graph/testlib.cc"
    "${tensorflow_source_dir}/tensorflow/core/kernels/ops_testutil.cc"
)

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
    #message(STATUS "${tensorflow_source_dir}/tensorflow/core/${file}") 
    list(APPEND tf_core_framework_test_srcs "${tensorflow_source_dir}/tensorflow/core/${file}")
endforeach(file ${})

if (WIN32)
#setenv can't find
list(REMOVE_ITEM tf_core_framework_test_srcs_files "util/reporter_test.cc")
endif (WIN32)

add_executable(test_framework ${tf_core_framework_test_srcs} $<TARGET_OBJECTS:tf_core_ops> $<TARGET_OBJECTS:tf_core_kernels> $<TARGET_OBJECTS:tf_core_framework_runtime_registration>)
target_link_libraries(test_framework test_util_main test_util_framework tf_core_framework)

add_executable(test_quantize_training
"${tensorflow_source_dir}/tensorflow/core/graph/quantize_training_test.cc"
 $<TARGET_OBJECTS:tf_core_ops>
 $<TARGET_OBJECTS:tf_core_kernels>
 $<TARGET_OBJECTS:tf_core_framework_runtime_registration>
)

target_link_libraries(test_quantize_training test_util_main test_util_framework tf_core_framework)