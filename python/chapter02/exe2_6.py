def main():
    print("This program calculates the future value of a 10-year investment.")
    years = eval(input("Enter the years of investment:"))
    principal = eval(input("Enter the initial principal:"))
    apr = eval(input("Enter the annual interest rate:"))
    for i in range(years):
        principal *= (1 + apr)
    print("The value in {} years is:{}".format(years, principal) )


main()

















