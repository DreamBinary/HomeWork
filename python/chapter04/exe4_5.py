import math

from graphics import *


def main():
    win = GraphWin(height=600, width=600)
    m1 = win.getMouse()
    m1.draw(win)
    m2 = win.getMouse()
    m2.draw(win)
    line = Line(m1, m2)
    line.setFill("teal")
    line.draw(win)

    sub1 = m2.getX() - m1.getX()
    sub2 = m2.getY() - m1.getY()

    text = Text(Point(100, 500), "slope = %.5f\nlength = %.5f" % (sub2 / sub1, math.sqrt(sub2 ** 2 + sub1 ** 2)))
    text.draw(win)

    win.getMouse()
    win.close()


main()



















