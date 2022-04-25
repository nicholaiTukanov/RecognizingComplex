module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main() -> tensor<3x3xf32> {
    %0 = mhlo.constant dense<1.000000e+00> : tensor<f32>
    %1 = mhlo.constant dense<0.000000e+00> : tensor<f32>
    %2 = mhlo.constant dense<3> : tensor<2xi64>
    %3 = "mhlo.rng_uniform"(%1, %0, %2) : (tensor<f32>, tensor<f32>, tensor<2xi64>) -> tensor<3x3xf32>
    %4 = "mhlo.rng_uniform"(%1, %0, %2) : (tensor<f32>, tensor<f32>, tensor<2xi64>) -> tensor<3x3xf32>
    %5 = "mhlo.dot"(%3, %4) : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    %6 = "mhlo.rng_uniform"(%1, %0, %2) : (tensor<f32>, tensor<f32>, tensor<2xi64>) -> tensor<3x3xf32>
    return %5 : tensor<3x3xf32>
  }
}

