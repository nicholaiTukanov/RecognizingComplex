def real_gemm(m, n, k, A, B, C):
    for i in range(m):
        for j in range(n):
            for p in range(k):
                C[i][j] += A[i][p] * B[p][j]
                

def complex_gemm(m, n, k, A, B, C):
    for i in range(m):
        for j in range(n):
            for p in range(k):
                C[i][j].real() += A[i][p].real() * B[p][j].real() - \
                                  A[i][p].imag() * B[p][j].imag()
                
                C[i][j].imag() += A[i][p].real() * B[p][j].imag() - \
                                  A[i][p].imag() * B[p][j].real()
                
import tensorflow as tf

def cgemm(Ar, Ai, Br, Bi, Cr, Ci):
    Cr += tf.matmul(Ar, Br) - \
        tf.matmul(Ai, Bi)
    Cr += tf.matmul(Ar, Bi) + \
        tf.matmul(Ai, Br)
    