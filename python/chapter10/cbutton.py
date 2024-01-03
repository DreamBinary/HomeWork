# cbutton.py
from math import sqrt

from graphics import *


class CButton:
    def __init__(self, win, center, radius, label):
        self.r = radius
        self.x = center.getX()
        self.y = center.getY()
        self.circ = Circle(center, self.r)
        self.circ.setFill('lightgray')
        self.circ.draw(win)
        self.label = Text(center, label)
        self.label.draw(win)
        self.deactivate()

    def getX(self):
        return float(self.x)

    def getY(self):
        return float(self.y)

    def getR(self):
        return float(self.r)

    def clicked(self, p):
        return (self.active and
                sqrt((p.getX() - self.getX()) ** 2 + (p.getY() - self.getY()) ** 2) <= self.getR())

    def getLabel(self):
        return self.label.getText()

    def activate(self):
        self.label.setFill('black')
        self.circ.setWidth(2)
        self.active = True

    def deactivate(self):
        self.label.setFill('darkgrey')
        self.circ.setWidth(1)
        self.active = False
