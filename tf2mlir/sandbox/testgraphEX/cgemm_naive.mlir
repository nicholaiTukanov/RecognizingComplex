module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main(%arg0: tensor<3x3xf32>, %arg1: tensor<3x3xf32>, %arg2: tensor<3x3xf32>, %arg3: tensor<3x3xf32>, %arg4: tensor<3x3xf32>, %arg5: tensor<3x3xf32>) -> tensor<*xcomplex<f32>> attributes {tf.entry_function = {control_outputs = "", inputs = "ar,ai,br,bi,cr,ci", outputs = "Identity"}} {
    %0 = tf_executor.graph {
      %outputs, %control = tf_executor.island wraps "tf.MatMul"(%arg1, %arg3) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<*xf32>
      %outputs_0, %control_1 = tf_executor.island wraps "tf.MatMul"(%arg0, %arg3) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<*xf32>
      %outputs_2, %control_3 = tf_executor.island wraps "tf.MatMul"(%arg0, %arg2) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<*xf32>
      %outputs_4, %control_5 = tf_executor.island wraps "tf.Sub"(%outputs_2, %outputs) {device = ""} : (tensor<*xf32>, tensor<*xf32>) -> tensor<*xf32>
      %outputs_6, %control_7 = tf_executor.island wraps "tf.MatMul"(%arg1, %arg2) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<*xf32>
      %outputs_8, %control_9 = tf_executor.island wraps "tf.AddV2"(%outputs_0, %outputs_6) {device = ""} : (tensor<*xf32>, tensor<*xf32>) -> tensor<*xf32>
      %outputs_10, %control_11 = tf_executor.island wraps "tf.Complex"(%outputs_4, %outputs_8) {device = ""} : (tensor<*xf32>, tensor<*xf32>) -> tensor<*xcomplex<f32>>
      %outputs_12, %control_13 = tf_executor.island wraps "tf.Identity"(%outputs_10) {device = ""} : (tensor<*xcomplex<f32>>) -> tensor<*xcomplex<f32>>
      tf_executor.fetch %outputs_12 : tensor<*xcomplex<f32>>
    }
    return %0 : tensor<*xcomplex<f32>>
  }
}
