module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main(%arg0: tensor<3x3xf32>, %arg1: tensor<3x3xf32>, %arg2: tensor<3x3xf32>, %arg3: tensor<3x3xf32>, %arg4: tensor<3x3xf32>, %arg5: tensor<3x3xf32>) -> tensor<*xcomplex<f32>> attributes {tf.entry_function = {control_outputs = "", inputs = "ar,ai,br,bi,cr,ci", outputs = "Identity"}} {
    %0 = "tf.MatMul"(%arg1, %arg3) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<*xf32>
    %1 = "tf.MatMul"(%arg0, %arg3) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<*xf32>
    %2 = "tf.MatMul"(%arg0, %arg2) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<*xf32>
    %3 = "tf.Sub"(%2, %0) {device = ""} : (tensor<*xf32>, tensor<*xf32>) -> tensor<*xf32>
    %4 = "tf.MatMul"(%arg1, %arg2) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<*xf32>
    %5 = "tf.AddV2"(%1, %4) {device = ""} : (tensor<*xf32>, tensor<*xf32>) -> tensor<*xf32>
    %6 = "tf.Complex"(%3, %5) {device = ""} : (tensor<*xf32>, tensor<*xf32>) -> tensor<*xcomplex<f32>>
    %7 = "tf.Identity"(%6) {device = ""} : (tensor<*xcomplex<f32>>) -> tensor<*xcomplex<f32>>
    return %7 : tensor<*xcomplex<f32>>
  }
}

