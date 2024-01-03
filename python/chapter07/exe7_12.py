import time


def pd(date):
    try:
        time.strptime(date, "%m/%d/%Y")
        return True
    except:
        return False


a = input("日期(mm/dd/yyyy): ")
if pd(a):
    print("有效")
else:
    print("无效")
