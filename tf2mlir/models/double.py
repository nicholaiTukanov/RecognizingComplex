import tensorflow as tf

def cgemm(A1, B1, C1, A2, B2, C2):

    # deinterleave
    A1_r, A1_i = tf.math.real(A1), tf.math.imag(A1)
    B1_r, B1_i = tf.math.real(B1), tf.math.imag(B1)
    C1_r, C1_i = tf.math.real(C1), tf.math.imag(C1)

    A2_r, A2_i = tf.math.real(A2), tf.math.imag(A2)
    B2_r, B2_i = tf.math.real(B2), tf.math.imag(B2)
    C2_r, C2_i = tf.math.real(C2), tf.math.imag(C2)

    # emulated cgemm
    C1_r = tf.matmul(A1_r, B1_r) - tf.matmul(A1_i, B1_i) + C1_r
    C1_i = tf.matmul(A1_r, B1_i) + tf.matmul(A1_i, B1_r) + C1_i

    C2_r = tf.matmul(A2_r, B2_r) - tf.matmul(A2_i, B2_i) + C2_r
    C2_i = tf.matmul(A2_r, B2_i) + tf.matmul(A2_i, B2_r) + C2_i

    # reinterleave
    C1 = tf.complex(C1_r, C1_i)
    C2 = tf.complex(C2_r, C2_i)

