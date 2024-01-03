def main():
    print("This program calculates the future value of a 10-year investment.")
    years = eval(input("Enter the years of investment:"))
    principal = eval(input("Enter the initial principal:"))
    t = principal
    apr = eval(input("Enter the annual interest rate:"))
    sum = 0
    for i in range(years):
        t *= 1 + apr
        sum += t
        t += principal
    print("The value in {} years is:{}".format(years, sum))


main()

















