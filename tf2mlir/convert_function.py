import tensorflow as tf
import time

@tf.function
def cgemm_direct(A, B, C):
    A_r, A_i = tf.math.real(A), tf.math.imag(A)
    B_r, B_i = tf.math.real(B), tf.math.imag(B)
    C_r, C_i = tf.math.real(C), tf.math.imag(C)

    C_r = tf.matmul(A_r, B_r) - tf.matmul(A_i, B_i) + C_r
    C_i = tf.matmul(A_r, B_i) + tf.matmul(A_i, B_r) + C_i

    C = tf.complex(C_r, C_i)
    return C

@tf.function
def cgemm_explict(A_r, A_i, B_r, B_i, C_r, C_i):
    return tf.complex(A_r @ B_r - A_i @ B_i + C_r, A_r @ B_i + A_i @ B_r + C_i)

@tf.function(autograph=True)
def main():
    m = 3
    n = 3
    k = 3
    A = tf.complex(tf.random.uniform(shape=[m,k], dtype=tf.float32), tf.random.uniform(shape=[m,k], dtype=tf.float32))
    B = tf.complex(tf.random.uniform(shape=[k,n], dtype=tf.float32), tf.random.uniform(shape=[k,n], dtype=tf.float32))
    C = tf.complex(tf.random.uniform(shape=[m,n], dtype=tf.float32), tf.random.uniform(shape=[m,n], dtype=tf.float32))
    s = time.time()
    cgemm_direct(A,B,C)
    elapsed = time.time() - s
    m, n, k = C.shape[0], C.shape[1], A.shape[1]
    print("\n*******GFLOPS******* = ", (8.0 * m * n * k) / (elapsed * 1e9), "\n")
    return C

def get_tf_mlir(func_obj):
    pass_pipe = ['tf-standard-pipeline', 'tf-data-optimization']
    for pass_ in pass_pipe:
        mlir_obj = tf.mlir.experimental.convert_graph_def(func_obj, pass_pipeline=pass_)
    return mlir_obj

def print_tf_mlir_(mlir_obj):
    print(mlir_obj)

def print_tf_mlir(func_obj):
    print_tf_mlir_(get_tf_mlir(func_obj))

def save_tf_mlir_(filename, mlir_obj):
    with open(filename, "w") as f:
        f.write(mlir_obj)

def save_tf_mlir(filename, func_obj):
    save_tf_mlir_(filename, get_tf_mlir(func_obj))


main_func = main.get_concrete_function().graph.as_graph_def()

# cgemm_direct_func = cgemm_direct.get_concrete_function(
#     tf.TensorSpec(shape=[m, k], dtype=tf.dtypes.complex64),
#     tf.TensorSpec(shape=[k, n], dtype=tf.dtypes.complex64),
#     tf.TensorSpec(shape=[m, n], dtype=tf.dtypes.complex64)
# )

# cgemm_explict_func = cgemm_explict.get_concrete_function(
#     tf.TensorSpec(shape=[m, k], dtype=tf.dtypes.float32, name="Ar"),
#     tf.TensorSpec(shape=[m, k], dtype=tf.dtypes.float32, name="Ai"),
#     tf.TensorSpec(shape=[k, n], dtype=tf.dtypes.float32, name="Br"),
#     tf.TensorSpec(shape=[k, n], dtype=tf.dtypes.float32, name="Bi"),
#     tf.TensorSpec(shape=[m, n], dtype=tf.dtypes.float32, name="Cr"),
#     tf.TensorSpec(shape=[m, n], dtype=tf.dtypes.float32, name="Ci")
# )

print_tf_mlir(main_func)
# print_tf_mlir(cgemm_direct_func)
# print_tf_mlir(cgemm_explict_func)


save_tf_mlir("main_test.mlir", main_func)
# save_tf_mlir("cgemm_direct_test.mlir", cgemm_direct_func)
# save_tf_mlir("cgemm_explict_func_test.mlir", cgemm_explict_func)