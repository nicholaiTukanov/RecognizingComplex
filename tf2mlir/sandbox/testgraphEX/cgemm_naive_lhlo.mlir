module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 987 : i32}} {
  func @main(%arg0: memref<3x3xf32>, %arg1: memref<3x3xf32>, %arg2: memref<3x3xf32>, %arg3: memref<3x3xf32>, %arg4: memref<3x3xf32>, %arg5: memref<3x3xf32>) -> memref<3x3xcomplex<f32>> attributes {tf.entry_function = {control_outputs = "", inputs = "ar,ai,br,bi,cr,ci", outputs = "Identity"}} {
    %0 = memref.alloc() : memref<3x3xf32>
    "lmhlo.dot"(%arg1, %arg3, %0) {dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [0]>} : (memref<3x3xf32>, memref<3x3xf32>, memref<3x3xf32>) -> ()
    %1 = memref.alloc() : memref<3x3xf32>
    "lmhlo.dot"(%arg0, %arg3, %1) {dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [0]>} : (memref<3x3xf32>, memref<3x3xf32>, memref<3x3xf32>) -> ()
    %2 = memref.alloc() : memref<3x3xf32>
    "lmhlo.dot"(%arg0, %arg2, %2) {dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [0]>} : (memref<3x3xf32>, memref<3x3xf32>, memref<3x3xf32>) -> ()
    %3 = memref.alloc() : memref<3x3xf32>
    "lmhlo.subtract"(%2, %0, %3) : (memref<3x3xf32>, memref<3x3xf32>, memref<3x3xf32>) -> ()
    %4 = memref.alloc() : memref<3x3xf32>
    "lmhlo.dot"(%arg1, %arg2, %4) {dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [0]>} : (memref<3x3xf32>, memref<3x3xf32>, memref<3x3xf32>) -> ()
    %5 = memref.alloc() : memref<3x3xf32>
    "lmhlo.add"(%1, %4, %5) : (memref<3x3xf32>, memref<3x3xf32>, memref<3x3xf32>) -> ()
    %6 = memref.alloc() : memref<3x3xcomplex<f32>>
    "lmhlo.complex"(%3, %5, %6) : (memref<3x3xf32>, memref<3x3xf32>, memref<3x3xcomplex<f32>>) -> ()
    return %6 : memref<3x3xcomplex<f32>>
  }
}

