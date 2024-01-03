import time


def fi1(n):
    if n == 1 or n == 2:
        return 1
    else:
        return fi1(n - 1) + fi1(n - 2)


def fi2(n):
    x = time.perf_counter()
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    y = time.perf_counter()
    print("y - x:{}".format(y - x))
    return a


print(fi1(int(input("n:"))))
print(fi2(int(input("n:"))))