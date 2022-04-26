
//  llvm-project/build/bin/mlir-opt
// 
// $ <mlir-opt> add-linalg-c.mlir -convert-linalg-to-loops -lower-affine -convert-scf-to-std -convert-std-to-llvm='emit-c-wrappers=1' | \
//   <mlir-translate> --mlir-to-llvmir | \
//   llc -mtriple=x86_64-apple-darwin --filetype=obj -o add-linalg-c.o
// $ clang add-main.c add-linalg-c.o -o add-main
// $ ./add-main
// [ 5 5 5 5 5 5 5 5 5 5 ]




#include <stdlib.h>
#include <stdio.h>
typedef long int intptr_t;
// Define Memref Descriptor.
typedef struct MemRef_descriptor_ *MemRef_descriptor;
typedef struct MemRef_descriptor_ {
int *allocated;
int *aligned;
intptr_t offset;
intptr_t sizes[1];
intptr_t strides[1];
} Memref;
Memref _mlir_ciface_tf_add(Memref *, Memref *);
int main()
{
Memref *arg0= (Memref *)malloc(sizeof(Memref));
Memref *arg1= (Memref *)malloc(sizeof(Memref));
Memref output;
int a[10]={2,2,2,2,2,2,2,2,2,2};
int b[10]={3,3,3,3,3,3,3,3,3,3};

arg0->aligned = a;
arg1->aligned = b;

output = _mlir_ciface_tf_add(arg0, arg1);

printf("[");
for(int i=0; i<10; i++)
{
printf("%d ",*(output.aligned+i));
}
printf("]\n");
}