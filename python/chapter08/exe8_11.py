a = list(map(int, input("每日平均温度(空格间隔)： ").split(" ")))
b = 0
c = 0

for i in a:
    if i < 60:
        b += 1
    elif i > 80:
        c += 1

print("制冷天数，加热天数:", b, c)


















