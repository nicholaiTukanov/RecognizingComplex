module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main(%arg0: tensor<2x2xf32>, %arg1: tensor<2x2xf32>, %arg2: tensor<2x1xf32>) -> tensor<*xf32> attributes {tf.entry_function = {control_outputs = "", inputs = "x,y,b", outputs = "Identity"}} {
    %0 = tf_executor.graph {
      %outputs, %control = tf_executor.island wraps "tf.MatMul"(%arg0, %arg1) {device = "", transpose_a = false, transpose_b = false} : (tensor<2x2xf32>, tensor<2x2xf32>) -> tensor<*xf32>
      %outputs_0, %control_1 = tf_executor.island wraps "tf.AddV2"(%outputs, %arg2) {device = ""} : (tensor<*xf32>, tensor<2x1xf32>) -> tensor<*xf32>
      %outputs_2, %control_3 = tf_executor.island wraps "tf.Identity"(%outputs_0) {device = ""} : (tensor<*xf32>) -> tensor<*xf32>
      tf_executor.fetch %outputs_2 : tensor<*xf32>
    }
    return %0 : tensor<*xf32>
  }
}
