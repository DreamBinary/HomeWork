def line_count(file):
    f = open(file, 'r', encoding="utf8")
    count = 0
    for _ in f:
        count += 1
    return count


def word_count(file):
    f = open(file, 'r', encoding="utf8")
    count = 0
    for line in f:
        words = line.split()
        count = count + len(words)
    return count


def char_count(file):
    f = open(file, 'r', encoding="utf8")
    count = 0
    for line in f:
        for _ in line:
            count = count + 1
    return count

# exe5_12.txt
filename = "exe5_12.txt"
print("lines:", line_count(filename))
print("words:", word_count(filename))
print("chars:", char_count(filename))

















