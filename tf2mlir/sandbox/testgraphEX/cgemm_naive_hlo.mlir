module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main(%arg0: tensor<3x3xf32>, %arg1: tensor<3x3xf32>, %arg2: tensor<3x3xf32>, %arg3: tensor<3x3xf32>, %arg4: tensor<3x3xf32>, %arg5: tensor<3x3xf32>) -> tensor<3x3xcomplex<f32>> attributes {tf.entry_function = {control_outputs = "", inputs = "ar,ai,br,bi,cr,ci", outputs = "Identity"}} {
    %0 = "mhlo.dot"(%arg1, %arg3) : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %1 = "mhlo.dot"(%arg0, %arg3) : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %2 = "mhlo.dot"(%arg0, %arg2) : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %3 = mhlo.subtract %2, %0 : tensor<3x3xf32>
    %4 = "mhlo.dot"(%arg1, %arg2) : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %5 = mhlo.add %1, %4 : tensor<3x3xf32>
    return %5 : tensor<3x3xcomplex<f32>>
  }
}

