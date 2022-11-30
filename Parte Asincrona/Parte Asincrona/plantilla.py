import numpy as np
import time
import ctypes
import matplotlib.pyplot as plt
import statistics

if __name__ == '__main__':
    N = 16
    array_np_test = np.random.uniform(0,10,N).astype(np.float32)
    out_test_C = np.zeros((N,1)).astype(np.float32)
    out_test_ASM = np.zeros((N,1)).astype(np.float32)
    out_test_ASM_SIMD = np.zeros((N,1)).astype(np.float32)

    lib = ctypes.CDLL('./lib.so')
    lib.my_C.argtypes = [np.ctypeslib.ndpointer(dtype = np.float32),np.ctypeslib.ndpointer(dtype = np.float32), ctypes.c_int ]
    lib.my_ASM.argtypes = [np.ctypeslib.ndpointer(dtype = np.float32),np.ctypeslib.ndpointer(dtype = np.float32), ctypes.c_int ]
    lib.my_ASM_SIMD.argtypes = [np.ctypeslib.ndpointer(dtype = np.float32),np.ctypeslib.ndpointer(dtype = np.float32), ctypes.c_int ]

    out_py = np.diff(array_np_test, n = 2)
    print(out_py)
    lib.my_C(array_np_test,out_test_C, N)
    print(out_test_C.flatten())
    lib.my_ASM(array_np_test,out_test_ASM, N)
    print(out_test_ASM.flatten())
    lib.my_ASM_SIMD(array_np_test,out_test_ASM_SIMD, N)
    print(out_test_ASM_SIMD.flatten())

    lista_num = [4, 16, 64,256,1024,4096,16384]
    iteraciones = 15

    lista_1 = []
    lista_2 = []
    lista_3 = []

    for n in lista_num:
        input_array = np.random.uniform(0,10,n).astype(np.float32)
        out_array_C = np.zeros((n,1)).astype(np.float32)
        out_array_ASM = np.zeros((n,1)).astype(np.float32)
        out_array_ASM_SIMD = np.zeros((n,1)).astype(np.float32)

        lista_C =[]
        lista_ASM =[]
        lista_ASM_SIMD = []

        for it in range(iteraciones):
            tic1 = time.time()
            lib.my_C(input_array,out_array_C, n)
            toc1 = time.time()
            lista_C.append(1e6*(toc1-tic1))

            tic2 = time.time()
            lib.my_ASM(input_array,out_array_ASM, n)
            toc2 = time.time()
            lista_ASM.append(1e6*(toc2-tic2))

            tic3 = time.time()
            lib.my_ASM_SIMD(input_array,out_array_ASM_SIMD, n)
            toc3 = time.time()
            lista_ASM_SIMD.append(1e6*(toc3-tic3))

        lista_1.append(statistics.median(lista_C))
        lista_2.append(statistics.median(lista_ASM))
        lista_3.append(statistics.median(lista_ASM_SIMD))

plt.plot(lista_num,lista_1,'r')
plt.plot(lista_num,lista_2,'b')
plt.plot(lista_num,lista_3,'g')
plt.xlabel("Size")
plt.ylabel("Tiempo [us]")
plt.grid()
plt.legend(['C','ASM', 'SIMD'])
plt.savefig("Grafica.png", dpi = 300)
plt.close()
