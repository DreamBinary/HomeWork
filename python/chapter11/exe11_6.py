import random


def shuffle(myList):
    n = 100
    while n >= 0:
        n -= 1
        k1 = random.randrange(0, len(myList))
        k2 = random.randrange(0, len(myList))
        myList[k1], myList[k2] = myList[k2], myList[k1]


def main():
    myList = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    shuffle(myList)
    print(myList)


main()