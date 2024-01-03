def main():
    date = input("Enter a date (mm/dd/yyyy):")
    month, day, year = date.split("/")

    months = ["January", "February", "March", "April", "May", "June ",
              "July", "August ", "September", "October", "November", "December"]
    month = months[int(month) - 1]
    print("The converted date is:{} {} {}".format(month, day, year))


main()
