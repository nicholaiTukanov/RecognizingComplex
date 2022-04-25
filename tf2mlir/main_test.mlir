module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}}  {
  func @main() {
    tf_executor.graph {
      %outputs, %control = tf_executor.island wraps "tf.Const"() {value = dense<1> : tensor<i32>} : () -> tensor<i32>
      %outputs_0, %control_1 = tf_executor.island wraps "tf.Const"() {value = dense<2> : tensor<i32>} : () -> tensor<i32>
      %outputs_2, %control_3 = tf_executor.island wraps "tf.AddV2"(%outputs, %outputs_0) {device = ""} : (tensor<i32>, tensor<i32>) -> tensor<i32>
      %outputs_4, %control_5 = tf_executor.island wraps "tf.StringFormat"(%outputs_2) {device = "", placeholder = "{}", summarize = 3 : i64, template = "{}"} : (tensor<i32>) -> tensor<!tf_type.string>
      %control_6 = tf_executor.island wraps "tf.PrintV2"(%outputs_4) {device = "", end = "\0A", output_stream = "stderr"} : (tensor<!tf_type.string>) -> ()
      %outputs_7, %control_8 = tf_executor.island(%control_6) wraps "tf.Identity"(%outputs_2) {device = ""} : (tensor<i32>) -> tensor<i32>
      tf_executor.fetch
    }
    return
  }
}
