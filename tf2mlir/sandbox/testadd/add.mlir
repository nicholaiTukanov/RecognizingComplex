module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 27 : i32}} {
  func @main(%arg0: tensor<10xi32>, %arg1: tensor<10xi32>) -> tensor<*xi32> attributes {tf.entry_function = {control_outputs = "", inputs = "input0,input1", outputs = "Add"}} {
    %0 = tf_executor.graph {
      %outputs, %control = tf_executor.island wraps "tf.Add"(%arg0, %arg1) {device = ""} : (tensor<10xi32>, tensor<10xi32>) -> tensor<*xi32>
      tf_executor.fetch %outputs : tensor<*xi32>
    }
    return %0 : tensor<*xi32>
  }
}
