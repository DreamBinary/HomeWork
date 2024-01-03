
import math

from graphics import *


def main():
    win = GraphWin(height=600, width=600)

    Text(Point(win.width // 2, 20), "矩形面积周长计算. 请点击两个点").draw(win)

    m1 = win.getMouse()
    m1.draw(win)
    m2 = win.getMouse()
    m2.draw(win)
    x1 = m1.getX()
    y1 = m1.getY()
    x2 = m2.getX()
    y2 = m2.getY()
    rec = Rectangle(m1, m2)
    rec.setFill("teal")
    rec.draw(win)
    sub1 = abs(x2 - x1)
    sub2 = abs(y2 - y1)
    text = Text(Point(100, 500), "面积 = %.2f\n周长 = %.2f" % (sub2 * sub1, sub2 * 2 + sub1 * 2))
    text.draw(win)

    win.getMouse()
    win.close()


main()





































