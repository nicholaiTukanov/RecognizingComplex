func @main() {
    %A = alloc() : memref<2048x2048xf64>
    %B = alloc() : memref<2048x2048xf64>
    %C = alloc() : memref<2048x2048xf64>
    %cf1 = constant 1.00000e+00 : f64
    linalg.fill(%A, %cf1) : memref<2048x2048xf64>, f64
    linalg.fill(%B, %cf1) : memref<2048x2048xf64>, f64
    linalg.fill(%C, %cf1) : memref<2048x2048xf64>, f64
    linalg.matmul : (memref<2048x2048xf64>, memref<2048x2048xf64>, memref<2048x2048xf64>) -> ()
    call @print_memref_2d_f64(%C): (memref<2048x2048xf64>) -> ()
    return
}