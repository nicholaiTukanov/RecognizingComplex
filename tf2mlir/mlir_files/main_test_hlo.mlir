module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main() -> tensor<i32> {
    %0 = mhlo.constant dense<3> : tensor<i32>
    return %0 : tensor<i32>
  }
}

