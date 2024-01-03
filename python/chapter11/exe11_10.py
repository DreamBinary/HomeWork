n = int(input("n = "))
l = [x for x in range(2, n + 1)]

while len(l) > 0:
    k = l[0]
    print(k)
    l = list(filter(lambda x: x % k != 0, l))
