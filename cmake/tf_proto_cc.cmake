################################################
# generate pb.* files form .proto
################################################

add_custom_target(generate_proto_cc
    COMMAND python script/gen_proto_cc.py
    WORKING_DIRECTORY ${tensorflow_root_dir}
)

#################################################
# tf_proto_cc_lib
#################################################

function(RELATIVE_PROTOBUF_GENERATE_CPP SRCS HDRS TEXT_SRCS TEXT_HDRS TEXT_HDRS_IMPL ROOT_DIR)
  if(NOT ARGN)
    message(SEND_ERROR "Error: RELATIVE_PROTOBUF_GENERATE_CPP() called without any proto files")
    return()
  endif()

  set(${SRCS})
  set(${HDRS})
  foreach(FIL ${ARGN})
    set(ABS_FIL ${ROOT_DIR}/${FIL})
    get_filename_component(FIL_WE ${FIL} NAME_WE)
    get_filename_component(FIL_DIR ${ABS_FIL} PATH)
    file(RELATIVE_PATH REL_DIR ${ROOT_DIR} ${FIL_DIR})

    list(APPEND ${SRCS} "${tensorflow_root_dir}/gencode/${REL_DIR}/${FIL_WE}.pb.cc")
    list(APPEND ${HDRS} "${tensorflow_root_dir}/gencode/${REL_DIR}/${FIL_WE}.pb.h")

	list(APPEND ${TEXT_SRCS} "${tensorflow_root_dir}/gencode/${REL_DIR}/${FIL_WE}.pb_text.cc")
    list(APPEND ${TEXT_HDRS} "${tensorflow_root_dir}/gencode/${REL_DIR}/${FIL_WE}.pb_text.h")
    list(APPEND ${TEXT_HDRS_IMPL} "${tensorflow_root_dir}/gencode/${REL_DIR}/${FIL_WE}.pb_text-impl.h")
  endforeach()

  set_source_files_properties(${${SRCS}} ${${HDRS}} ${${TEXT_SRCS}} ${${TEXT_HDRS}} ${${TEXT_HDRS_IMPL}} PROPERTIES GENERATED TRUE)
  set(${SRCS} ${${SRCS}} PARENT_SCOPE)
  set(${HDRS} ${${HDRS}} PARENT_SCOPE)
  set(${TEXT_SRCS} ${${TEXT_SRCS}} PARENT_SCOPE)
  set(${TEXT_HDRS} ${${TEXT_HDRS}} PARENT_SCOPE)
  set(${TEXT_HDRS_IMPL} ${${TEXT_HDRS_IMPL}} PARENT_SCOPE)
endfunction()

set(tf_proto_srcs
    "tensorflow/core/example/example.proto"
    "tensorflow/core/example/feature.proto"
    "tensorflow/core/framework/api_def.proto"
    "tensorflow/core/framework/allocation_description.proto"
    "tensorflow/core/framework/attr_value.proto"
    "tensorflow/core/framework/cost_graph.proto"
    "tensorflow/core/framework/device_attributes.proto"
    "tensorflow/core/framework/function.proto"
    "tensorflow/core/framework/graph.proto"
    "tensorflow/core/framework/graph_transfer_info.proto"
    "tensorflow/core/framework/kernel_def.proto"
    "tensorflow/core/framework/log_memory.proto"
    "tensorflow/core/framework/node_def.proto"
    "tensorflow/core/framework/op_def.proto"
    "tensorflow/core/framework/remote_fused_graph_execute_info.proto"
    "tensorflow/core/framework/resource_handle.proto"
    "tensorflow/core/framework/step_stats.proto"
    "tensorflow/core/framework/summary.proto"
    "tensorflow/core/framework/tensor.proto"
    "tensorflow/core/framework/tensor_description.proto"
    "tensorflow/core/framework/tensor_shape.proto"
    "tensorflow/core/framework/tensor_slice.proto"
    "tensorflow/core/framework/types.proto"
    "tensorflow/core/framework/versions.proto"
    "tensorflow/core/lib/core/error_codes.proto"
    "tensorflow/core/protobuf/cluster.proto"
    "tensorflow/core/protobuf/config.proto"
    "tensorflow/core/protobuf/debug.proto"
    "tensorflow/core/protobuf/queue_runner.proto"
    "tensorflow/core/protobuf/device_properties.proto"
    "tensorflow/core/protobuf/rewriter_config.proto"
    "tensorflow/core/protobuf/tensor_bundle.proto"
    "tensorflow/core/protobuf/saver.proto"
    "tensorflow/core/protobuf/meta_graph.proto" #need by tf_cc
    "tensorflow/core/protobuf/saved_model.proto" #need by tf_cc
    "tensorflow/core/util/memmapped_file_system.proto"
    "tensorflow/core/util/saved_tensor_slice.proto"
    "tensorflow/core/util/event.proto"
    "tensorflow/core/grappler/costs/op_performance_data.proto"
    "tensorflow/core/util/test_log.proto" #todo put it to somewhere
	"tensorflow/core/util/example_proto_fast_parsing_test.proto" #todo put it to somewhere
)

RELATIVE_PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS
	PROTO_TEXT_SRCS PROTO_TEXT_HDRS PROTO_TEXT_IMPL_HDRS
    ${tensorflow_source_dir} ${tf_proto_srcs}
)

add_library(tf_proto_cc_lib ${PROTO_SRCS} ${PROTO_HDRS})
add_dependencies(tf_proto_cc_lib generate_proto_cc)
