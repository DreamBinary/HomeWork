import math

from graphics import *


def main(r, y):
    win = GraphWin(height=600, width=600)
    center_x = win.width / 2
    center_y = win.height / 2

    cir = Circle(Point(center_x, center_y), r * 25)
    cir.setFill("pink")
    cir.draw(win)
    line = Line(Point(0, center_y - y * 25), Point(1200, center_y - y * 25))
    line.setFill("red")
    line.draw(win)

    Line(Point(0, center_y), Point(1200, center_y)).draw(win)
    Line(Point(center_x, 0), Point(center_x, 1200)).draw(win)

    for i in range(24):
        Line(Point(25 * i, center_y), Point(25 * i, center_y - 5)).draw(win)
    for i in range(24):
        Line(Point(center_x, 25 * i), Point(center_x + 5, 25 * i)).draw(win)
    win.getMouse()
    win.close()


rr = int(input("半径："))
yy = int(input("截距："))
xx = math.sqrt(rr ** 2 - yy ** 2)
print("x1={}, x2 ={}".format(-xx, xx))
main(rr, yy)




















