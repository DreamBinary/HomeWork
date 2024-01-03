def removeDuplicates1(somelist):
    return list(set(somelist))


def removeDuplicates2(somelist):
    l = []
    for i in somelist:
        if i not in l:
            l.append(i)
    return l


def main():
    l = [8, 2, 7, 7, 9, 4, 4, 4, 6, 6, 5, 3, 1]
    print(removeDuplicates1(l))
    print(removeDuplicates2(l))


main()
