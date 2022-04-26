
//  llvm-project/build/bin/mlir-opt
// 
// $ <mlir-opt> add-linalg-c.mlir -convert-linalg-to-loops -lower-affine -convert-scf-to-std -convert-std-to-llvm='emit-c-wrappers=1' | \
//   <mlir-translate> --mlir-to-llvmir | \
//   llc -mtriple=x86_64-apple-darwin --filetype=obj -o add-linalg-c.o
// $ clang add-main.c add-linalg-c.o -o add-main
// $ ./add-main
// [ 5 5 5 5 5 5 5 5 5 5 ]


#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <omp.h>

/*

    Driver code to linalg functions

*/



// special 
typedef struct memref_descriptor_ *memref_descriptor;

typedef long int intptr_t;

template <typename T>
struct memref_descriptor_ {
    T *allocated;
    T *aligned;
    intptr_t offset;
    intptr_t sizes[1];
    intptr_t strides[1];
} memref;

typedef memref<int16_t> i16_memref;
typedef memref<int32_t> i32_memref;

// deinterleaved naive kernel
void linalg_cgemm_naive(
    memref *Ar, memref *Ai, 
    memref *Br, memref *Bi,
    memref *Cr, memref *Ci
);

void linalg_cgemm_opt_4m(
    memref *A, // interleaved
    memref *B, // interleaved
    memref *C // interleaved
);

void linalg_cgemm_opt_1m(
    memref *A, // 1m format
    memref *B, // interleaved
    memref *C // interleaved
);

#define MAX_VAL 5

template <typename T>
void init_mat(T **mat, int elems) {
    *mat = (int16_t *) malloc(elems * sizeof(int16_t));
    for(int i=0;i<elems;i++)
        mat[i] = ((T) (rand() % MAX_VAL));
}

void init_i16_memref(i16_memref *mat, int elems) {
    int16_t *mat_;
    init_mat(&mat_, elems);
    mat->aligned = mat_;
}


void mlir_linalg_function(int m, int n, int k) {

    i16_memref *Ar = (i16_memref *)malloc(sizeof(i16_memref));
    i16_memref *Ai = (i16_memref *)malloc(sizeof(i16_memref));
    i16_memref *Br = (i16_memref *)malloc(sizeof(i16_memref));
    i16_memref *Bi = (i16_memref *)malloc(sizeof(i16_memref));
    i32_memref *Cr = (i32_memref *)malloc(sizeof(i32_memref));
    i32_memref *Ci = (i32_memref *)malloc(sizeof(i32_memref));

    init_i16_memref(Ar, m*k); init_i16_memref(Ai, m*k);
    init_i16_memref(Br, n*k); init_i16_memref(Bi, n*k);
    init_i16_memref(Cr, m*n); init_i16_memref(Ci, m*n);

    double s,e,min_elapsed=1e9; // timing stuff
    int NUM_RUNS = 5; // set repeats

    // get best throughput out of NUM_RUNS trials of the kernel
    for (int i=0; i<NUM_RUNS; i++) {

        // time kernel
        s = omp_get_wtime();
        linalg_cgemm_naive(
            Ar, Ai, 
            Br, Bi,
            Cr, Ci
        );
        e = omp_get_wtime();

        min_elapsed = std::min(min_elapsed, e-s);

    }

    // todo: measure correctness

    printf("GFLOPS = %.2f\n", (8.0*m*n*k) / (min_elapsed*1e9));

    // todo: free it lol

};


int main(int argc, char *argv[]) {

    int m, n, k;

    if(argc == 4) {
        m = atoi(argv[1]);
        n = atoi(argv[2]);
        k = atoi(argv[3]);
    }
    else {
        m = n = k = 512;
    }
    

    mlir_linalg_function(m, n, k);

}