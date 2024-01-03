def main1():
    print("(main1)This program illustrate a chaotic function")
    x = eval(input("Enter a number between 0 and 1:"))
    for i in range(10):
        x = 3.9 * x * (1 - x)
    print(x)


def main2():
    print("(main2)This program illustrate a chaotic function")
    x = eval(input("Enter a number between 0 and 1:"))
    for i in range(10):
        x = 3.9 * (x - x * x)
    print(x)


def main3():
    print("(main3)This program illustrate a chaotic function")
    x = eval(input("Enter a number between 0 and 1:"))
    for i in range(10):
        x = 3.9 * x - 3.9 * x * x
    print(x)


main1()
main2()
main3()





































