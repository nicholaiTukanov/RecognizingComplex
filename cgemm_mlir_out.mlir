module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}}  {
  func @__inference_cgemm_explict_19(%arg0: tensor<3x3xf32> {tf._user_specified_name = "Ar"}, 
    %arg1: tensor<3x3xf32> {tf._user_specified_name = "Ai"}, 
    %arg2: tensor<3x3xf32> {tf._user_specified_name = "Br"}, 
    %arg3: tensor<3x3xf32> {tf._user_specified_name = "Bi"}, 
    %arg4: tensor<3x3xf32> {tf._user_specified_name = "Cr"}, 
    %arg5: tensor<3x3xf32> {tf._user_specified_name = "Ci"}) -> tensor<3x3xcomplex<f32>> 
    attributes {tf.entry_function = {control_outputs = "", inputs = "ar,ai,br,bi,cr,ci", outputs = "identity_RetVal"}} {
    %0 = "tf.MatMul"(%arg1, %arg3) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %1 = "tf.MatMul"(%arg0, %arg3) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %2 = "tf.MatMul"(%arg0, %arg2) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %3 = "tf.Sub"(%2, %0) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %4 = "tf.MatMul"(%arg1, %arg2) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %5 = "tf.AddV2"(%1, %4) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %6 = "tf.AddV2"(%5, %arg5) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %7 = "tf.AddV2"(%3, %arg4) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %8 = "tf.Complex"(%7, %6) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xcomplex<f32>>
    %9 = "tf.Identity"(%8) {device = ""} : (tensor<3x3xcomplex<f32>>) -> tensor<3x3xcomplex<f32>>
    return %9 : tensor<3x3xcomplex<f32>>
  }
}