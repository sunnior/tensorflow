#include "tensorflow/cc/client/client_session.h"
#include "tensorflow/cc/ops/standard_ops.h"
#include "tensorflow/core/framework/tensor.h"
#include "tensorflow/cc/saved_model/loader.h"
#include "tensorflow/core/framework/tensor_testutil.h"

int main() {
  using namespace tensorflow;
  using namespace tensorflow::ops;
  
  const string export_dir = "code/demo/loader/test_model_conv";
  SavedModelBundle bundle;
  SessionOptions session_options;
  RunOptions run_options;

  Status status = LoadSavedModel(session_options, run_options, export_dir, {"test_model_conv"}, &bundle);

  printf("%s\n", status.ToString().c_str());

  float data[32][32][3];
  float* pdata = &data[0][0][0];

  for (int i = 0; i < 32*32*3; ++i)
  {
    *(pdata + i) = 1.0f;
  }
  gtl::ArraySlice<float> dataArray(pdata, 32*32*3);
  Tensor input_tensor = test::AsTensor(dataArray, {1, 32, 32, 3});

  std::vector<std::pair<string, Tensor>> feeds{{"input", input_tensor}};
  std::vector<string> output_tensor_names{"relu"};
  std::vector<string> target_node_names;
  std::vector<Tensor> outputs;

  const GraphDef& graph_def = bundle.meta_graph_def.graph_def();
  bundle.session->Run(run_options, feeds, output_tensor_names, target_node_names, &outputs, nullptr);
  Tensor tensor = outputs[0];
  auto p_data = tensor.flat<float>();
  int size = p_data.size();
  float* p_out_data = p_data.data();

  for (int i = 0; i < 16; ++i)
  {
    printf("%f ", *(p_out_data + i));
    for (int j = 0; j < 16; ++j)
    {
        printf("%.1f ", *(p_out_data + i* 16 +j));
    }
    printf("\n");
  }
  return 0;
}
