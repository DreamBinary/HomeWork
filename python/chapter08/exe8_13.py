from graphics import *

value_x = []
value_y = []
win = GraphWin("13", 500, 500)


def cal():
    count = len(value_x)
    sum_xy = sum(map(lambda x, y: x * y, value_x, value_y))
    sum_x2 = sum(map(lambda x: x ** 2, value_x))
    ave_x = sum(value_x) / count
    ave_y = sum(value_y) / count
    m = (sum_xy - count * ave_x * ave_y) / (sum_x2 - count * ave_x ** 2)
    y0 = ave_y - m * ave_x
    y500 = ave_y + m * (500 - ave_x)
    line_draw(y0, y500)


def win_draw():
    Text(Point(250, 15), "请在下面指定数据点").draw(win)
    Rectangle(Point(0, 500), Point(50, 470)).draw(win)
    Text(Point(25, 485), "Done").draw(win)


def line_draw(y0, y500):
    Line(Point(0, y0), Point(500, y500)).draw(win)


def enter():
    while True:
        dot = win.getMouse()
        x = dot.getX()
        y = dot.getY()
        if 0 <= x <= 50 and 470 <= y <= 500:
            cal()
            break
        Point(x, y).draw(win)
        value_x.append(x)
        value_y.append(y)


def main():
    win_draw()
    enter()
    win.getMouse()


main()
