module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main(%arg0: tensor<2x2xf32>, %arg1: tensor<2x2xf32>, %arg2: tensor<2x1xf32>) -> tensor<2x2xf32> attributes {tf.entry_function = {control_outputs = "", inputs = "x,y,b", outputs = "Identity"}} {
    %0 = "mhlo.dot"(%arg0, %arg1) : (tensor<2x2xf32>, tensor<2x2xf32>) -> tensor<2x2xf32>
    %1 = "mhlo.broadcast_in_dim"(%arg2) {broadcast_dimensions = dense<[0, 1]> : tensor<2xi64>} : (tensor<2x1xf32>) -> tensor<2x2xf32>
    %2 = mhlo.add %0, %1 : tensor<2x2xf32>
    return %2 : tensor<2x2xf32>
  }
}

