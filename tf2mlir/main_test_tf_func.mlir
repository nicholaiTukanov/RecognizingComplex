module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main() ->  tensor<i32> {
    %cst = "tf.Const"() {value = dense<1> : tensor<i32>} : () -> tensor<i32>
    %cst_0 = "tf.Const"() {value = dense<2> : tensor<i32>} : () -> tensor<i32>
    %0 = "tf.AddV2"(%cst, %cst_0) {device = ""} : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %2 = "tf.Identity"(%0) {device = ""} : (tensor<i32>) -> tensor<i32>
    return %2 :  tensor<i32>
  }
}

