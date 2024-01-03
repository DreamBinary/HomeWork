xy = list(map(int, input("请输入下x1, y1, x2, y2：").split(" ")))
print("斜率为：{:.2f}".format((xy[3] - xy[1]) / (xy[2] - xy[0])))