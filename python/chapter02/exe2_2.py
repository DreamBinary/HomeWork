import sys


def main():
    celsius = eval(input("What is the Celsius temperature?"))
    fahrenheit = (9 / 5) * celsius + 32
    print("The temperature is ", fahrenheit, " degrees Fahrenheit")


main()
k = input("Press the <Enter> key to quit.")
while k != "":
    k = input("Press the <Enter> key to quit.")
sys.exit()




















