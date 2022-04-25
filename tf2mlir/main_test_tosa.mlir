module attributes {tf.versions = {bad_consumers = [], min_consumer = 12 : i32, producer = 987 : i32}} {
  func @main() {
    %0 = "tosa.const"() {value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
    %1 = "tf.RandomUniform"(%0) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
    %2 = "tf.RandomUniform"(%0) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
    %3 = "tf.RandomUniform"(%0) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
    %4 = "tf.RandomUniform"(%0) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
    %5 = "tf.RandomUniform"(%0) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
    %6 = "tf.RandomUniform"(%0) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
    return
  }
}

