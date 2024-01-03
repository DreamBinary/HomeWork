def innerProd(x, y):
    return sum(list(map(lambda a, b: a * b, [a for a in x], [b for b in y])))


def main():
    l1 = [5, 6, 8, 4, 2, 1, 3, 7, 9]
    l2 = [8, 2, 7, 9, 4, 6, 5, 3, 1]
    print(innerProd(l1, l2))


main()