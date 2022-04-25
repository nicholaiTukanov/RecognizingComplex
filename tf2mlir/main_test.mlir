module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}}  {
  func @main() {
    tf_executor.graph {
      %outputs, %control = tf_executor.island wraps "tf.StringFormat"() {device = "", placeholder = "{}", summarize = 3 : i64, template = "0.00026252380875108663"} : () -> tensor<!tf_type.string>
      %control_0 = tf_executor.island wraps "tf.PrintV2"(%outputs) {device = "", end = "\0A", output_stream = "stderr"} : (tensor<!tf_type.string>) -> ()
      %outputs_1, %control_2 = tf_executor.island wraps "tf.Const"() {value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
      %outputs_3, %control_4 = tf_executor.island wraps "tf.RandomUniform"(%outputs_1) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
      %outputs_5, %control_6 = tf_executor.island wraps "tf.Const"() {value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
      %outputs_7, %control_8 = tf_executor.island wraps "tf.RandomUniform"(%outputs_5) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
      %outputs_9, %control_10 = tf_executor.island wraps "tf.AddV2"(%outputs_3, %outputs_7) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
      %outputs_11, %control_12 = tf_executor.island wraps "tf.MatMul"(%outputs_3, %outputs_7) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
      %outputs_13, %control_14 = tf_executor.island(%control_0) wraps "tf.Identity"(%outputs_11) {device = ""} : (tensor<3x3xf32>) -> tensor<3x3xf32>
      %outputs_15, %control_16 = tf_executor.island wraps "tf.Const"() {value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
      %outputs_17, %control_18 = tf_executor.island wraps "tf.RandomUniform"(%outputs_15) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
      tf_executor.fetch
    }
    return
  }
}
