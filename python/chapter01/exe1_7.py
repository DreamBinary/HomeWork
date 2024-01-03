def main():
    x = eval(input("1) Enter a number between 0 and 1:"))
    y = eval(input("2) Enter a number between 0 and 1:"))
    print("Input:%14f" % x, "Input:%14f" % y)
    for i in range(20):
        x = 3.9 * x * (1 - x)
        y = 3.9 * x * (1 - x)
        print("%20f" % x, "%20f" % y)


main()
























































