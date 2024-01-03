def count(myList, x):
    n = 0
    for i in myList:
        if i == x:
            n += 1
    return n


def isin(myList, x):
    for i in myList:
        if i == x:
            return True
    return False


def index(myList, x):
    n = 0
    for i in myList:
        if i == x:
            return n
        n += 1


def reverse(myList):
    reList = []
    for i in myList[-1::-1]:
        reList.append(i)
    return reList


def sort(myList):
    for i in range(0, len(myList)):
        for j in range(i, len(myList)):
            if myList[i] > myList[j]:
                myList[i], myList[j] = myList[j], myList[i]


def main():
    myList = [1, 6, 3, 4, 2, 3, 4, 6, 9, 7, 4, 2, 1, 3]
    print(count(myList, 2))
    print(isin(myList, 10), isin(myList, 1))
    print(index(myList, 6))
    ll = reverse(myList)
    print(ll)
    sort(myList)
    print(myList)


main()
