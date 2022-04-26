# Assumes tf 2.8
import tensorflow as tf

@tf.function
def cgemm_explict(A_r, A_i, B_r, B_i, C_r, C_i):
    return tf.complex(A_r @ B_r - A_i @ B_i + C_r, A_r @ B_i + A_i @ B_r + C_i)


m, n, k = 3, 3, 3
func_obj = cgemm_explict.get_concrete_function(
    tf.TensorSpec(shape=[m, k], dtype=tf.dtypes.float32, name="Ar"),
    tf.TensorSpec(shape=[m, k], dtype=tf.dtypes.float32, name="Ai"),
    tf.TensorSpec(shape=[k, n], dtype=tf.dtypes.float32, name="Br"),
    tf.TensorSpec(shape=[k, n], dtype=tf.dtypes.float32, name="Bi"),
    tf.TensorSpec(shape=[m, n], dtype=tf.dtypes.float32, name="Cr"),
    tf.TensorSpec(shape=[m, n], dtype=tf.dtypes.float32, name="Ci")
)
mlir_obj = tf.mlir.experimental.convert_function(func_obj, pass_pipeline='tf-standard-pipeline')
print(mlir_obj) # print tf MLIR for the given tf.function