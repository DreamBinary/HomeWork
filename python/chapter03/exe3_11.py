import math

n = int(input("n:"))
flag = 1
mpi = 0
for i in range(1, 2 * n, 2):
    mpi += 4 / i * flag
    flag *= -1

print("前n项的和：%.6f 与Pi差值为：%.6f}" % (mpi, mpi - math.pi))
