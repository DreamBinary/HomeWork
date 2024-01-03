y = int(input("年份： "))
if 1982 <= y <= 2048:
    a = y % 19
    b = y % 4
    c = y % 7
    d = (19 * a + 24) % 30
    e = (2 * b + 4 * c + 6 * d + 5) % 7
    f = e + d
    if f + 22 > 31:
        print("4月%d日" % (f + 22 - 31))
    else:
        print("3月%d日" % (f + 22))
else:
    print("年份输入错误")
