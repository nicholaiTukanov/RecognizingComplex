module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main(%arg0: tensor<2x2xf32>, %arg1: tensor<2x2xf32>, %arg2: tensor<2x1xf32>) -> tensor<*xf32> attributes {tf.entry_function = {control_outputs = "", inputs = "x,y,b", outputs = "Identity"}} {
    %0 = "tf.MatMul"(%arg0, %arg1) {device = "", transpose_a = false, transpose_b = false} : (tensor<2x2xf32>, tensor<2x2xf32>) -> tensor<*xf32>
    %1 = "tf.AddV2"(%0, %arg2) {device = ""} : (tensor<*xf32>, tensor<2x1xf32>) -> tensor<*xf32>
    %2 = "tf.Identity"(%1) {device = ""} : (tensor<*xf32>) -> tensor<*xf32>
    return %2 : tensor<*xf32>
  }
}

