import random


class Card:
    def __init__(self, rank, suit):
        self.r = rank
        self.s = suit

    def getRank(self):
        if self.r == 1:
            return "A"
        elif self.r == 11:
            return "J"
        elif self.r == 12:
            return "Q"
        elif self.r == 13:
            return "K"
        else:
            return str(self.r)

    def getSuit(self):
        if self.s == "d":
            return "方块"
        elif self.s == "c":
            return "草花"
        elif self.s == "h":
            return "红心"
        else:
            return "黑桃"

    def value(self):
        if self.r < 9:
            return self.r
        else:
            return 10

    def __str__(self):
        return self.getSuit() + " 的 " + self.getRank()


def main():
    n = int(input("几张纸牌: "))
    for i in range(n):
        r = random.randrange(1, 14)
        s = random.choice("dchs")
        print(Card(r, s))


main()