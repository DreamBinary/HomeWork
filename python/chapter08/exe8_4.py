def syr(x):
    if x % 2 == 0:
        return x / 2
    else:
        return 3 * x + 1


a = int(input("起始值： "))

while a != 1:
    print(a, end="    ")
    a = int(syr(a))
print(1)

















