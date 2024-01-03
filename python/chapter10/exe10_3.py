import random

from graphics import *

win = GraphWin("exe10_3", 800, 800)
Text(Point(150, 150), "Door1").draw(win)
Rectangle(Point(100, 100), Point(200, 200)).draw(win)
Text(Point(350, 150), "Door2").draw(win)
Rectangle(Point(300, 100), Point(400, 200)).draw(win)
Text(Point(550, 150), "Door3").draw(win)
Rectangle(Point(500, 100), Point(600, 200)).draw(win)

k = random.randrange(1, 4)

dot = win.getMouse()
x = dot.getX()
y = dot.getY()

if 100 <= x <= 200 and 100 <= y <= 200 and k == 1:
    Text(Point(350, 300), "你赢了").draw(win)
elif 300 <= x <= 400 and 100 <= y <= 200 and k == 2:
    Text(Point(350, 300), "你赢了").draw(win)
elif 500 <= x <= 600 and 100 <= y <= 200 and k == 2:
    Text(Point(350, 300), "你赢了").draw(win)
else:
    Text(Point(350, 300), "你输了").draw(win)
