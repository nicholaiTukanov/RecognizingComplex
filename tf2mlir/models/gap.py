import tensorflow as tf

def cgemm_gap(A, B, C):
    A_r, A_i = tf.math.real(A), tf.math.imag(A)
    B_r, B_i = tf.math.real(B), tf.math.imag(B)
    C_r, C_i = tf.math.real(C), tf.math.imag(C)

    C_r = tf.matmul(A_r, B_r) - tf.matmul(A_i, B_i) + C_r

    i = 0
    a = 2
    while i < 10:
        i+=1
    
    if (i == 10):
        a = 5

    C_i = tf.matmul(A_r, B_i) + tf.matmul(A_i, B_r) + C_i

    C = tf.complex(C_r, C_i)