a, b = map(float, input("开始时间(hh:mm) ").split(":"))
c, d = map(float, input("结束时间(hh:mm) ").split(":"))

print(a, b, c, d)
if c <= 21:
    print((c - d + (d - b) / 60) * 2.5)
else:
    print((21 - a - b / 60) * 2.5 + (c - 21 + d / 60) * 1.75)


















