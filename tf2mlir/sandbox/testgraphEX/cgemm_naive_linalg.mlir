#map = affine_map<(d0, d1) -> (d0, d1)>
module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @linalg_cgemm_naive(%arg0: tensor<3x3xf32>, %arg1: tensor<3x3xf32>, %arg2: tensor<3x3xf32>, %arg3: tensor<3x3xf32>, %arg4: tensor<3x3xf32>, %arg5: tensor<3x3xf32>) -> tensor<3x3xcomplex<f32>> attributes {tf.entry_function = {control_outputs = "", inputs = "ar,ai,br,bi,cr,ci", outputs = "Identity"}} {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = linalg.init_tensor [3, 3] : tensor<3x3xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<3x3xf32>) -> tensor<3x3xf32>
    %2 = linalg.matmul ins(%arg1, %arg3 : tensor<3x3xf32>, tensor<3x3xf32>) outs(%1 : tensor<3x3xf32>) -> tensor<3x3xf32>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %3 = linalg.init_tensor [3, 3] : tensor<3x3xf32>
    %4 = linalg.fill ins(%cst_0 : f32) outs(%3 : tensor<3x3xf32>) -> tensor<3x3xf32>
    %5 = linalg.matmul ins(%arg0, %arg3 : tensor<3x3xf32>, tensor<3x3xf32>) outs(%4 : tensor<3x3xf32>) -> tensor<3x3xf32>
    %cst_1 = arith.constant 0.000000e+00 : f32
    %6 = linalg.init_tensor [3, 3] : tensor<3x3xf32>
    %7 = linalg.fill ins(%cst_1 : f32) outs(%6 : tensor<3x3xf32>) -> tensor<3x3xf32>
    %8 = linalg.matmul ins(%arg0, %arg2 : tensor<3x3xf32>, tensor<3x3xf32>) outs(%7 : tensor<3x3xf32>) -> tensor<3x3xf32>
    %9 = linalg.init_tensor [3, 3] : tensor<3x3xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%8, %2 : tensor<3x3xf32>, tensor<3x3xf32>) outs(%9 : tensor<3x3xf32>) {
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %18 = arith.subf %arg6, %arg7 : f32
      linalg.yield %18 : f32
    } -> tensor<3x3xf32>
    %cst_2 = arith.constant 0.000000e+00 : f32
    %11 = linalg.init_tensor [3, 3] : tensor<3x3xf32>
    %12 = linalg.fill ins(%cst_2 : f32) outs(%11 : tensor<3x3xf32>) -> tensor<3x3xf32>
    %13 = linalg.matmul ins(%arg1, %arg2 : tensor<3x3xf32>, tensor<3x3xf32>) outs(%12 : tensor<3x3xf32>) -> tensor<3x3xf32>
    %14 = linalg.init_tensor [3, 3] : tensor<3x3xf32>
    %15 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%5, %13 : tensor<3x3xf32>, tensor<3x3xf32>) outs(%14 : tensor<3x3xf32>) {
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %18 = arith.addf %arg6, %arg7 : f32
      linalg.yield %18 : f32
    } -> tensor<3x3xf32>
    %16 = linalg.init_tensor [3, 3] : tensor<3x3xcomplex<f32>>
    %17 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%10, %15 : tensor<3x3xf32>, tensor<3x3xf32>) outs(%16 : tensor<3x3xcomplex<f32>>) {
    ^bb0(%arg6: f32, %arg7: f32, %arg8: complex<f32>):
      %18 = complex.create %arg6, %arg7 : complex<f32>
      linalg.yield %18 : complex<f32>
    } -> tensor<3x3xcomplex<f32>>
    return %17 : tensor<3x3xcomplex<f32>>
  }
}

