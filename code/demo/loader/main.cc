#include "tensorflow/cc/client/client_session.h"
#include "tensorflow/cc/ops/standard_ops.h"
#include "tensorflow/core/framework/tensor.h"
#include "tensorflow/cc/saved_model/loader.h"
#include "tensorflow/core/framework/tensor_testutil.h"

int main() {
  using namespace tensorflow;
  using namespace tensorflow::ops;
  
  const string export_dir = "code/demo/loader/test_dir";
  SavedModelBundle bundle;
  SessionOptions session_options;
  RunOptions run_options;

  LoadSavedModel(session_options, run_options, export_dir, {"test_graph"}, &bundle);

  std::vector<std::pair<string, Tensor>> feeds{{"input_x", test::AsTensor<float>({1.0f})}};
  std::vector<string> output_tensor_names{"target_add"};
  std::vector<string> target_node_names;
  std::vector<Tensor> outputs;

  const GraphDef& graph_def = bundle.meta_graph_def.graph_def();
  bundle.session->Run(run_options, feeds, output_tensor_names, target_node_names, &outputs, nullptr);
  Tensor tensor = outputs[0];
  auto p_data = tensor.flat<float>();
  return 0;
}
