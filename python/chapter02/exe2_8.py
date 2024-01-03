def main():
    print("This program calculates the future value of a 10-year investment.")
    principal = eval(input("Enter the initial principal:"))
    periods = eval(input("Enter the periods of every year"))
    apr = eval(input("Enter the annual interest rate:"))
    sum = 0
    for i in range(10 * periods):
        principal *= (1 + apr / periods)
    print("The value in 10 years is:{}".format(sum))


main()

















