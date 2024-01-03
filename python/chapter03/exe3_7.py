import math

xy = list(map(int, input("请输入下x1, y1, x2, y2：").split(" ")))
print("距离为：{:.2f}".format(math.sqrt((xy[3] - xy[1]) ** 2 + (xy[2] - xy[0]) ** 2)))