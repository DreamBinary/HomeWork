def main1(ch):
    alphabet1 = "abcdefghizklmnopqrstuvwxyzabcdefghizklmnopqrstuvwxyz"
    alphabet2 = alphabet1.upper()
    if ch.islower():
        print(alphabet1[alphabet1.find(ch) + key], end="")
    else:
        print(alphabet2[alphabet2.find(ch) + key], end="")


def main2(ch):
    if ch.islower:
        if ord(ch) + key > ord("z"):
            print(chr(ord(ch) + key - 26), end="")
        else:
            print(chr(ord(ch) + key), end="")
    else:
        if ord(ch) + key > ord("Z"):
            print(chr(ord(ch) + key - 26), end="")
        else:
            print(chr(ord(ch) + key), end="")


str_ = input("字符串：")
key = int(input("密钥的值："))
for i in str_:
    main1(i)
print()
for i in str_:
    main2(i)






















