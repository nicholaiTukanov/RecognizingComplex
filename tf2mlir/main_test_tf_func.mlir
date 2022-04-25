module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main() ->  tensor<3x3xf32> {
    %0 = "tf.StringFormat"() {device = "", placeholder = "{}", summarize = 3 : i64, template = "0.00026252380875108663"} : () -> tensor<!tf_type.string>
    %cst = "tf.Const"() {value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
    %1 = "tf.RandomUniform"(%cst) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
    %cst_0 = "tf.Const"() {value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
    %2 = "tf.RandomUniform"(%cst_0) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
    %3 = "tf.AddV2"(%1, %2) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %4 = "tf.MatMul"(%1, %2) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %5 = "tf.Identity"(%4) {device = ""} : (tensor<3x3xf32>) -> tensor<3x3xf32>
    %cst_1 = "tf.Const"() {value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
    %6 = "tf.RandomUniform"(%cst_1) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
    return %4 : tensor<3x3xf32>
  }
}

