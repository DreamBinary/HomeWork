
import math

from graphics import *


def main():
    win = GraphWin(height=600, width=600)

    Text(Point(win.width // 2, 20), "三角形面积周长计算. 请点击三个点").draw(win)
    m1 = win.getMouse()
    m1.draw(win)
    m2 = win.getMouse()
    m2.draw(win)
    m3 = win.getMouse()
    m3.draw(win)
    x1 = m1.getX()
    y1 = m1.getY()
    x2 = m2.getX()
    y2 = m2.getY()
    x3 = m3.getX()
    y3 = m3.getY()
    tri = Polygon(m1, m2, m3)
    tri.setFill("red")
    tri.draw(win)
    a = math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)
    b = math.sqrt((x3 - x1) ** 2 + (y3 - y1) ** 2)
    c = math.sqrt((x2 - x3) ** 2 + (y2 - y3) ** 2)
    s = (a + b + c) / 2

    text = Text(Point(100, 500), "面积 = %.2f\n周长 = %.2f" % (math.sqrt(s * (s - a) * (s - b) * (s - c)), a + b + c))
    text.draw(win)

    win.getMouse()
    win.close()


main()
























































