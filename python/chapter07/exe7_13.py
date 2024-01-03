import time


def pd(date):
    try:
        time.strptime(date, "%m/%d/%Y")
        return True
    except:
        return False


def isRun(year):
    if (year % 4) == 0:
        if (year % 100) == 0:
            if (year % 400) == 0:
                return True
            else:
                return False
        else:
            return True
    else:
        return False


a = input("日期(mm/dd/yyyy): ")
m, d, y = map(int, a.split("/"))
if pd(a):
    dayNum = 31 * (m - 1) + d
    if m > 2:
        dayNum -= (4 * m + 23) // 10
    if isRun(y) and m > 2:
        dayNum += 1
    print("天数： ", dayNum)
else:
    print("无效")
