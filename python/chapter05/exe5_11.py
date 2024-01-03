def main():
    print("This program calculates the future value")
    print("of a 10-year investment.")

    principal = eval(input("Enter the initial principal:"))
    apr = eval(input("Enter the annual interest rate:"))
    years = eval(input("Enter the years:"))
    print("{:<10s}{}".format("Year", "Value"))
    print("-------------------")
    for i in range(years):
        print("{:<10d}${:.2f}".format(i, principal))
        principal = principal * (1 + apr)


main()



















