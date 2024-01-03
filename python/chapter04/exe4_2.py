from graphics import *


# 30 90 150 210 270
def main():
    win = GraphWin(height=700, width=700)
    colors = ["white", "black", "blue", "red", "yellow"]
    r = 270
    color = 0
    while r >= 30:
        cir = Circle(Point(win.width / 2, win.height / 2), r)
        cir.setFill(colors[color])
        cir.draw(win)
        r -= 60
        color += 1
    win.getMouse()
    win.close()


main()
