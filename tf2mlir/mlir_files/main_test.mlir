module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}}  {
  func @main() {
    tf_executor.graph {
      %outputs, %control = tf_executor.island wraps "tf.Const"() {value = dense<1> : tensor<i32>} : () -> tensor<i32>
      %outputs_0, %control_1 = tf_executor.island wraps "tf.Const"() {value = dense<2> : tensor<i32>} : () -> tensor<i32>
      %outputs_2, %control_3 = tf_executor.island wraps "tf.AddV2"(%outputs, %outputs_0) {device = ""} : (tensor<i32>, tensor<i32>) -> tensor<i32>
      %outputs_4, %control_5 = tf_executor.island wraps "tf.Identity"(%outputs_2) {device = ""} : (tensor<i32>) -> tensor<i32>
      tf_executor.fetch
    }
    return
  }
}
