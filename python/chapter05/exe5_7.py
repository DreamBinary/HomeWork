str_ = input("字符串：")
key = int(input("密钥的值："))
for i in list(map(lambda ch: chr(ord(ch) + key), [i for i in str_])):
    print(i, end="")