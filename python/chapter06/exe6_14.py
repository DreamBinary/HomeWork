def read_square(filename):
    with open(filename) as nums:
        return sum(map(lambda i: sumList(squareEach(toNumbers(i.strip().split(" ")))), nums.readlines()))


def squareEach(nums):
    return list(map(lambda x: x * x, nums))


def sumList(nums):
    return sum(nums)


def toNumbers(strList):
    return list(map(int, strList))


print(read_square("pro.txt"))
