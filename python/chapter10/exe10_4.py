import random

from graphics import *

win = GraphWin("exe10_3", 800, 800)
Text(Point(150, 150), "Door1").draw(win)
Rectangle(Point(100, 100), Point(200, 200)).draw(win)
Text(Point(350, 150), "Door2").draw(win)
Rectangle(Point(300, 100), Point(400, 200)).draw(win)
Text(Point(550, 150), "Door3").draw(win)
Rectangle(Point(500, 100), Point(600, 200)).draw(win)
Text(Point(350, 550), "Quit").draw(win)
Rectangle(Point(300, 500), Point(400, 600)).draw(win)
yy = 300
while True:
    k = random.randrange(1, 4)
    dot = win.getMouse()
    x = dot.getX()
    y = dot.getY()
    if 300 <= x <= 400 and 500 <= y <= 600:
        break
    elif 100 <= x <= 200 and 100 <= y <= 200 and k == 1:
        Text(Point(350, yy), "你赢了").draw(win)
    elif 300 <= x <= 400 and 100 <= y <= 200 and k == 2:
        Text(Point(350, yy), "你赢了").draw(win)
    elif 500 <= x <= 600 and 100 <= y <= 200 and k == 2:
        Text(Point(350, yy), "你赢了").draw(win)
    else:
        Text(Point(350, yy), "你输了, 正确的是Door" + str(k)).draw(win)
    yy += 25

win.close()
