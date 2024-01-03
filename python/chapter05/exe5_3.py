def main(grade):
    if grade < 60:
        return "F"
    elif grade <= 69:
        return "D"
    elif grade <= 79:
        return "C"
    elif grade <= 89:
        return "B"
    elif grade <= 100:
        return "A"
    else:
        return "输入错误！"


print(main(int(input("考试成绩："))))


















