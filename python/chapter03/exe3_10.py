import math

height = float(input("height:"))
angle = float(input("angle(°)："))
print("length:%.2f" % (height / math.sin(math.pi * angle / 180)))
