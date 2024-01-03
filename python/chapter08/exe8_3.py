a = float(input("年利率： "))
b = 1
c = b
d = 0
while c < 2 * b:
    c += c * a
    d += 1
print(d)
