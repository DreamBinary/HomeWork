# -*- coding:utf-8 -*-
# @FileName : fractal_tree.py
# @Time : 2024/5/10 16:46
# @Author : fiv

import turtle as t
class Tree:
    def __init__(self, root_pos: tuple[float, float], length: float, offset_angle: float, tree_angle: float = 30):
        self.length = length
        self.offset_angle = offset_angle
        self.tree_angle = tree_angle
        self.root_pos = root_pos

    def draw(self, has_root=True):
        t.penup()
        t.goto(self.root_pos)
        t.setheading(self.offset_angle)
        t.pendown()
        if has_root:
            t.fd(self.length * 0.75)  # AC
        C = t.pos()
        dC = t.heading()
        t.rt(self.tree_angle)
        t.fd(self.length)  # CE
        E = t.pos()
        dE = t.heading()
        t.bk(self.length)  # C
        t.lt(2 * self.tree_angle)
        t.fd(self.length)  # CD
        D = t.pos()
        dD = t.heading()
        t.bk(self.length)  # C
        t.rt(self.tree_angle)
        t.fd(self.length * 1.25)  # CB
        B = t.pos()
        dB = t.heading()
        t.rt(self.tree_angle)
        t.fd(self.length)  # BG
        G = t.pos()
        dG = t.heading()
        t.bk(self.length)  # B
        t.lt(2 * self.tree_angle)
        t.fd(self.length)  # BF
        F = t.pos()
        dF = t.heading()
        t.bk(self.length)  # B
        t.rt(self.tree_angle)
        return ({'B': B, 'C': C, 'D': D, 'E': E, 'F': F, 'G': G},
                {'B': dB, 'C': dC, 'D': dD, 'E': dE, 'F': dF, 'G': dG})


def draw(pos, length, offset_angle, has_root, tree_angle):
    if length < min_length:
        return
    tree = Tree(root_pos=pos, length=length, offset_angle=offset_angle, tree_angle=tree_angle)
    pos, ang = tree.draw(has_root=has_root)
    points = ["E", "D", "G", "F", "B"]
    for point in points:
        if point == "B":
            draw(pos[point], length * 0.8, ang[point] - 10, has_root=True, tree_angle=45)
        else:
            draw(pos[point], length * 0.4, ang[point] - 10, has_root=False, tree_angle=30)


if __name__ == '__main__':
    t.setup(800, 800)
    t.speed(0)
    init_pos = (0, -400)
    init_length = 20
    init_tree_angle = 45
    min_length = 5
    draw(init_pos, 100, 90, has_root=True, tree_angle=init_tree_angle)
    t.hideturtle()
    t.getcanvas().postscript(file='fractal_tree.eps')
    t.done()

# pseduo code
"""
def draw(pos, length, offset_angle, has_root, tree_angle):
    if length < min_length:
        return
    # 利用一阶树的数据结构, 画一个树返回树的各个位置和角度, ang and pos
    points = ["E", "D", "G", "F", "B"]
    # 依次递归画出各个点,先画树枝，在画树干
    for point in points:
        if point == "B": # 主树干
            draw(pos[point], length * 0.8, ang[point] - 10, has_root=True, tree_angle=45)
        else:
            draw(pos[point], length * 0.4, ang[point] - 10, has_root=False, tree_angle=30)
"""
