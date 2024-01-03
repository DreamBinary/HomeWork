y = int(input("年份： "))
if 1900 <= y <= 2099:
    a = y % 19
    b = y % 4
    c = y % 7
    d = (19 * a + 24) % 30
    e = (2 * b + 4 * c + 6 * d + 5) % 7
    f = e + d
    if y == 1954 or y == 1981 or y == 2049 or y == 2076:
        if f + 22 + 7 > 31:
            print("4月%d日" % (f + 22 + 7 - 31))
        else:
            print("3月%d日" % (f + 22 + 7))
    else:
        if f + 22 > 31:
            print("4月%d日" % (f + 22 - 31))
        else:
            print("3月%d日" % (f - 22))
else:
    print("年份输入错误")
