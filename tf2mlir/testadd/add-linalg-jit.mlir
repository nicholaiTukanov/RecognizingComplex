
func.func @example(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %0 = memref.dim %arg0, %c0 : memref<?xf32>
  scf.for %arg2 = %c0 to %0 step %c1 {
    %1 = memref.load %arg0[%arg2] : memref<?xf32>
    %2 = memref.load %arg1[%arg2] : memref<?xf32>
    %3 = arith.addf %1, %2 : f32
  }
  return
}