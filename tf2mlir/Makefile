
MLIR_PATH = /home/nicholai/prog/software/llvm-project/build

MLIR_OPT = $(MLIR_PATH)/bin/mlir-opt
OPT_FLAGS = -convert-linalg-to-loops --lower-affine --convert-scf-to-cf --convert-cf-to-llvm

MLIR_TRANS = $(MLIR_PATH)/bin/mlir-translate
TRANS_FLAGS = --mlir-to-llvmir

MLIR2OBJ = llc
MLIR2OBJ_FLAGS = --filetype=obj

CC = g++
CFLAGS = -std=c++11 -fopenmp

LIBS = -fopenmp

# c compile rule
%.o: %.cpp
	$(CC)  -c $< $(CFLAGS) -o $@

# mlir opt rule
%.opt.mlir: %.mlir
	$(MLIR_OPT) $^ $(OPT_FLAGS) -o $@

# translate rule
%.llvmir: %.opt.mlir
	$(MLIR_TRANS) $^ $(TRANS_FLAGS) -o $@

# llvm ir compile rule
%.o: %.llvmir
	$(MLIR2OBJ) $^ $(MLIR2OBJ_FLAGS) -o $@

LINKER = $(CC)

driver.x: driver.o linalg_cgemm_naive.o
	$(LINKER)  $(LIBS) -o $@

clean:
	rm -rf *.o *.x