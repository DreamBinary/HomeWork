# -*- coding:utf-8 -*-
# @FileName : octree.py
# @Time : 2024/5/8 18:46
# @Author : fiv


import numpy as np

np.set_printoptions(threshold=np.inf)


# 切成八个小立方体
def split(ccube):
    x, y, z = ccube.shape
    cube_l = []
    for ii in range(2):
        for j in range(2):
            for k in range(2):
                cube_l.append(
                    ccube[ii * x // 2: (ii + 1) * x // 2, j * y // 2: (j + 1) * y // 2, k * z // 2: (k + 1) * z // 2])
    return cube_l


def is_all_one(cube):
    return np.all(cube == 1)


def is_all_zero(cube):
    return np.all(cube == 0)


if __name__ == '__main__':
    big_cube = np.zeros((32, 32, 32), dtype=int)
    # cube0 shape: [17, 17, 3]
    # cube1 shape: [13, 13, 13]
    # [17, 17, 3] in big_cube is 1
    cube0 = np.ones((17, 17, 3))
    big_cube[0: 17, 0: 17, 0:3] = cube0
    cube1 = np.ones((13, 13, 13))
    big_cube[1: 14, 1: 14, 3:16] = cube1
    cube_list = [([], [big_cube])]
    for i in range(6):
        print("=========>> 第", i + 1, "层有", sum([len(cubes) for _, cubes in cube_list]), "个立方体",
              cube_list[0][1][0].shape)
        tmp = cube_list
        cube_list = []
        white = 0
        grey = 0
        black = 0
        for (idx, tmpp) in enumerate(tmp):
            tidx, tcubes = tmpp

            for (ci, cube) in enumerate(tcubes):
                # print(cube.shape)
                path = tidx.copy()
                path.append(ci)
                if is_all_one(cube):
                    print(i + 1, "层", "父亲索引", path, "end 1")
                    black += 1
                elif is_all_zero(cube):
                    print(i + 1, "层", "父亲索引", path, "end 0")
                    white += 1
                else:
                    cubes = split(cube)
                    cube_list.append((path, cubes))
                    grey += 1
        print("第", i + 1, "层", "白", white, "灰", grey, "黑", black)
