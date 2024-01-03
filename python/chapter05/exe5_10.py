words = input("句子（单词以空格断开）：").split(" ")

sum_ = 0
for i in words:
    sum_ += len(i)

print(sum_ / len(words))



































