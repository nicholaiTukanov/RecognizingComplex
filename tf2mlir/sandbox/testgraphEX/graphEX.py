import tensorflow as tf
import time

# Define a Python function.
# def a_regular_function(x, y, b):
#   x = tf.matmul(x, y)
#   x = x + b
#   return x

def cgemm_naive(ar, ai, br, bi, cr, ci):
  cr = tf.matmul(ar, br) - tf.matmul(ai, bi)
  ci = tf.matmul(ar, bi) + tf.matmul(ai, br)
  return tf.complex(cr, ci)

# `a_function_that_uses_a_graph` is a TensorFlow `Function`.
# a_function_that_uses_a_graph = tf.function(a_regular_function)
cgemm_naive_tf_func = tf.function(cgemm_naive)

# Make some tensors.

ar = tf.constant([[1.0,2.0,3.0],[4.0,5.0,6.0],[7.0,8.0,9.0]])
ai = tf.constant([[1.0,2.0,3.0],[4.0,5.0,6.0],[7.0,8.0,9.0]])
br = tf.constant([[1.0,2.0,3.0],[4.0,5.0,6.0],[7.0,8.0,9.0]])
bi = tf.constant([[1.0,2.0,3.0],[4.0,5.0,6.0],[7.0,8.0,9.0]])
cr = tf.constant([[1.0,2.0,3.0],[4.0,5.0,6.0],[7.0,8.0,9.0]])
ci = tf.constant([[1.0,2.0,3.0],[4.0,5.0,6.0],[7.0,8.0,9.0]])

# x1 = tf.constant([[1.0, 2.0],[1.0, 2.0] ])
# y1 = tf.constant([[2.0, 2.0], [3.0, 3.0]])
# b1 = tf.constant([[1.0, 2.0]])

c_out = cgemm_naive(ar, ai, br, bi, cr, ci).numpy()

# Call a `Function` like a Python function.
c_ref = cgemm_naive_tf_func(ar, ai, br, bi, cr, ci).numpy()

assert((c_out == c_ref).all())

graph_obj = cgemm_naive_tf_func.get_concrete_function(ar, ai, br, bi, cr, ci).graph.as_graph_def()

with open("cgemm_naive.pbtxt", "w") as f:
  f.write(graph_obj.__str__())

