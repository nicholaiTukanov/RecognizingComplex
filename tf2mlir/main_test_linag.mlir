#map0 = affine_map<(d0, d1) -> ()>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main() -> tensor<3x3xf32> {
    %cst = arith.constant dense<1.000000e+00> : tensor<f32>
    %cst_0 = arith.constant dense<0.000000e+00> : tensor<f32>
    %cst_1 = arith.constant dense<3> : tensor<2xi64>
    %0 = linalg.init_tensor [3, 3] : tensor<3x3xf32>
    %1 = linalg.generic {indexing_maps = [#map0, #map0, #map1], iterator_types = ["parallel", "parallel"]} ins(%cst_0, %cst : tensor<f32>, tensor<f32>) outs(%0 : tensor<3x3xf32>) {
    ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
      %c0_i32 = arith.constant 0 : i32
      %c1103515245_i32 = arith.constant 1103515245 : i32
      %c12345_i32 = arith.constant 12345 : i32
      %9 = linalg.index 0 : index
      %10 = arith.index_cast %9 : index to i32
      %11 = arith.addi %10, %c0_i32 : i32
      %12 = arith.muli %11, %c1103515245_i32 : i32
      %13 = arith.addi %12, %c12345_i32 : i32
      %14 = linalg.index 1 : index
      %15 = arith.index_cast %14 : index to i32
      %16 = arith.addi %15, %13 : i32
      %17 = arith.muli %16, %c1103515245_i32 : i32
      %18 = arith.addi %17, %c12345_i32 : i32
      %cst_3 = arith.constant 2.32830644E-10 : f32
      %19 = arith.subf %arg1, %arg0 : f32
      %20 = arith.mulf %19, %cst_3 : f32
      %21 = arith.uitofp %18 : i32 to f32
      %22 = arith.mulf %21, %20 : f32
      %23 = arith.addf %22, %arg0 : f32
      linalg.yield %23 : f32
    } -> tensor<3x3xf32>
    %2 = linalg.init_tensor [3, 3] : tensor<3x3xf32>
    %3 = linalg.generic {indexing_maps = [#map0, #map0, #map1], iterator_types = ["parallel", "parallel"]} ins(%cst_0, %cst : tensor<f32>, tensor<f32>) outs(%2 : tensor<3x3xf32>) {
    ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
      %c0_i32 = arith.constant 0 : i32
      %c1103515245_i32 = arith.constant 1103515245 : i32
      %c12345_i32 = arith.constant 12345 : i32
      %9 = linalg.index 0 : index
      %10 = arith.index_cast %9 : index to i32
      %11 = arith.addi %10, %c0_i32 : i32
      %12 = arith.muli %11, %c1103515245_i32 : i32
      %13 = arith.addi %12, %c12345_i32 : i32
      %14 = linalg.index 1 : index
      %15 = arith.index_cast %14 : index to i32
      %16 = arith.addi %15, %13 : i32
      %17 = arith.muli %16, %c1103515245_i32 : i32
      %18 = arith.addi %17, %c12345_i32 : i32
      %cst_3 = arith.constant 2.32830644E-10 : f32
      %19 = arith.subf %arg1, %arg0 : f32
      %20 = arith.mulf %19, %cst_3 : f32
      %21 = arith.uitofp %18 : i32 to f32
      %22 = arith.mulf %21, %20 : f32
      %23 = arith.addf %22, %arg0 : f32
      linalg.yield %23 : f32
    } -> tensor<3x3xf32>
    %cst_2 = arith.constant 0.000000e+00 : f32
    %4 = linalg.init_tensor [3, 3] : tensor<3x3xf32>
    %5 = linalg.fill ins(%cst_2 : f32) outs(%4 : tensor<3x3xf32>) -> tensor<3x3xf32>
    %6 = linalg.matmul ins(%1, %3 : tensor<3x3xf32>, tensor<3x3xf32>) outs(%5 : tensor<3x3xf32>) -> tensor<3x3xf32>
    %7 = linalg.init_tensor [3, 3] : tensor<3x3xf32>
    %8 = linalg.generic {indexing_maps = [#map0, #map0, #map1], iterator_types = ["parallel", "parallel"]} ins(%cst_0, %cst : tensor<f32>, tensor<f32>) outs(%7 : tensor<3x3xf32>) {
    ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
      %c0_i32 = arith.constant 0 : i32
      %c1103515245_i32 = arith.constant 1103515245 : i32
      %c12345_i32 = arith.constant 12345 : i32
      %9 = linalg.index 0 : index
      %10 = arith.index_cast %9 : index to i32
      %11 = arith.addi %10, %c0_i32 : i32
      %12 = arith.muli %11, %c1103515245_i32 : i32
      %13 = arith.addi %12, %c12345_i32 : i32
      %14 = linalg.index 1 : index
      %15 = arith.index_cast %14 : index to i32
      %16 = arith.addi %15, %13 : i32
      %17 = arith.muli %16, %c1103515245_i32 : i32
      %18 = arith.addi %17, %c12345_i32 : i32
      %cst_3 = arith.constant 2.32830644E-10 : f32
      %19 = arith.subf %arg1, %arg0 : f32
      %20 = arith.mulf %19, %cst_3 : f32
      %21 = arith.uitofp %18 : i32 to f32
      %22 = arith.mulf %21, %20 : f32
      %23 = arith.addf %22, %arg0 : f32
      linalg.yield %23 : f32
    } -> tensor<3x3xf32>
    return %6 : tensor<3x3xf32>
  }
}

