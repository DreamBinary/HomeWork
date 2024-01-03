import math


class Sphere:
    def __init__(self, radius):
        self.r = radius

    def getRadius(self):
        return self.r

    def surfaceArea(self):
        return 4 * math.pi * self.r ** 2

    def volume(self):
        return 4 / 3 * self.r ** 3 * math.pi


def main():
    r = int(input("球体半径 : "))
    s = Sphere(r)
    print("球体半径：{0: 0.1f}, 球体表面积：{1: 0.1f},球体体积：{2: 0.1f}" .format(s.getRadius(), s.surfaceArea(), s.volume()))


main()