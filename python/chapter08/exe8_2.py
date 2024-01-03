def zhishu(v, t):
    return 35.74 + 0.6215 * t - 35.75 * v ** 0.16 + 0.4275 * t * v ** 0.16


print(" " * 8, end="")
for i in range(5, 51, 5):
    print("%8d" % i, end="")
print()
for j in range(-20, 61, 10):
    print("%8d" % j, end="")
    for i in range(5, 51, 5):
        print("%8d" % zhishu(i, j), end="")
    print()
