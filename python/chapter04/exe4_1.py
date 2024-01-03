from graphics import *


def main():
    win = GraphWin(height=500, width=500)
    center_x = win.width / 2
    center_y = win.height / 2
    shape = Rectangle(Point(center_x - 25, center_y - 25), Point(center_x + 25, center_y + 25))
    shape.setOutline("red")
    shape.setFill("red")
    shape.draw(win)
    for i in range(10):
        p = win.getMouse()
        shape1 = Rectangle(Point(p.getX() - 25, p.getY() - 25), Point(p.getX() + 25, p.getY() + 25))
        shape1.setFill("green")
        shape1.draw(win)
    text = Text(Point(center_x, center_y), "Click again to quit!")
    text.setSize(36)

    text.draw(win)
    win.getMouse()
    win.close()


main()
