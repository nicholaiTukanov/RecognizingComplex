#map0 = affine_map<(d0, d1) -> (d0, 0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main(%arg0: tensor<2x2xf32>, %arg1: tensor<2x2xf32>, %arg2: tensor<2x1xf32>) -> tensor<2x2xf32> attributes {tf.entry_function = {control_outputs = "", inputs = "x,y,b", outputs = "Identity"}} {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = linalg.init_tensor [2, 2] : tensor<2x2xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<2x2xf32>) -> tensor<2x2xf32>
    %2 = linalg.matmul ins(%arg0, %arg1 : tensor<2x2xf32>, tensor<2x2xf32>) outs(%1 : tensor<2x2xf32>) -> tensor<2x2xf32>
    %3 = linalg.init_tensor [2, 2] : tensor<2x2xf32>
    %4 = linalg.generic {indexing_maps = [#map0, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg2 : tensor<2x1xf32>) outs(%3 : tensor<2x2xf32>) {
    ^bb0(%arg3: f32, %arg4: f32):
      linalg.yield %arg3 : f32
    } -> tensor<2x2xf32>
    %5 = linalg.init_tensor [2, 2] : tensor<2x2xf32>
    %6 = linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel", "parallel"]} ins(%2, %4 : tensor<2x2xf32>, tensor<2x2xf32>) outs(%5 : tensor<2x2xf32>) {
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %7 = arith.addf %arg3, %arg4 : f32
      linalg.yield %7 : f32
    } -> tensor<2x2xf32>
    return %6 : tensor<2x2xf32>
  }
}

