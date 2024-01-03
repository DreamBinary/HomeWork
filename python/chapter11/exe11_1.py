from math import sqrt


def mean(nums):
    return sum(nums) / len(nums)


def stdDev(nums):
    m = mean(nums)
    return sqrt(sum(list(map(lambda x: (x - m) ** 2, [x for x in nums]))) / len(nums))


def meanStdDev(nums):
    return mean(nums), stdDev(nums)


def main():
    nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    print(mean(nums))
    print(stdDev(nums))
    print(meanStdDev(nums))


main()
