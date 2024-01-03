a = int(input("速度限制："))
b = int(input("计时速度："))
c = 0
if b <= a:
    print("速度合法")
else:
    if b <= 90:
        print("罚款", (b - a) * 5 + 50)
    else:
        print("罚款", (a - b) * 5 + 250)


















