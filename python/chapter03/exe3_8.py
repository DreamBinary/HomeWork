year = int(input("年份："))
c = year // 100
epact = (8 + (c // 4) - c + ((8 * c + 13) // 25) + 11 * (year % 19)) % 30
print(epact)