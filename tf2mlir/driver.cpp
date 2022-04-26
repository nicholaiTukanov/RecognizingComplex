
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
#include <unistd.h>
#include <string.h>
#include "omp.h"

using namespace std;

/*

    Driver code to linalg functions

*/



// special 
typedef struct memref_descriptor_ *memref_descriptor;

typedef long int intptr_t;


// typedef struct memref_descriptor_ {
//     short *allocated;
//     short *aligned;
//     intptr_t offset;
//     intptr_t sizes[1];
//     intptr_t strides[1];
// } memref;

#define DTYPE float

typedef struct memref_descriptor_ {
    DTYPE *allocated;
    DTYPE *aligned;
    intptr_t offset;
    intptr_t sizes[1];
    intptr_t strides[1];
} memref;


// deinterleaved naive kernel
memref* linalg_cgemm_naive(
    memref *, memref *, 
    memref *, memref *,
    memref *, memref *
);

// memref* linalg_cgemm_opt_4m(
//     memref *A, // interleaved
//     memref *B, // interleaved
//     memref *C // interleaved
// );

// memref* linalg_cgemm_opt_1m(
//     memref *A, // 1m format
//     memref *B, // interleaved
//     memref *C // interleaved
// );

#define MAX_VAL 5

void init_mat(DTYPE **mat, int elems) {
    *mat = (DTYPE *) malloc(elems * sizeof(DTYPE));
    for(int i=0;i<elems;i++)
        (*mat)[i] = ((DTYPE) (rand() % MAX_VAL));
}

void init_memref(memref *mat, int elems) {
    DTYPE *mat_;
    init_mat(&mat_, elems);
    mat->aligned = mat_;
}

#define min(x,y) (x) < (y) ? (x) : (y)

void mlir_linalg_function(int m, int n, int k) {

    memref *Ar = (memref *)malloc(sizeof(memref));
    memref *Ai = (memref *)malloc(sizeof(memref));
    memref *Br = (memref *)malloc(sizeof(memref));
    memref *Bi = (memref *)malloc(sizeof(memref));
    memref *Cr = (memref *)malloc(sizeof(memref));
    memref *Ci = (memref *)malloc(sizeof(memref));
    memref *C =  (memref *)malloc(sizeof(memref));

    init_memref(Ar, m*k); init_memref(Ai, m*k);
    init_memref(Br, n*k); init_memref(Bi, n*k);
    init_memref(Cr, m*n); init_memref(Ci, m*n);

    double s,e,min_elapsed=1e9; // timing stuff
    int NUM_RUNS = 5; // set repeats

    // get best throughput out of NUM_RUNS trials of the kernel
    for (int i=0; i<NUM_RUNS; i++) {

        // time kernel
        s = omp_get_wtime();
        Cr = linalg_cgemm_naive(
            Ar, Ai, 
            Br, Bi,
            Cr, Ci
        );
        e = omp_get_wtime();

        min_elapsed = min(min_elapsed, e-s);

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
        m = n = k = 3;
    }
    

    mlir_linalg_function(m, n, k);

}