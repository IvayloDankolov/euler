import datetime


firsts_of_months = (datetime.datetime(year, month, 1) for year in range(1901, 2001) for month in range(1, 13))

first_sundays = filter(lambda d: d.weekday() == 6, firsts_of_months)

print(len(list(first_sundays)))