import csv
import statistics
from datetime import datetime

if __name__ == '__main__':
    with open(r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400/data/fred_cpi.csv', 'r',encoding='utf8') as cpi_file:
        cpi = csv.reader(cpi_file)
        print([item for item in cpi])

    all_values = []
    all_dates = []
    with open(r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400/data/fred_cpi.csv', 'r',encoding='utf8') as cpi_file:
        cpi = csv.reader(cpi_file)
        for row in cpi:
            all_dates.append(datetime.strptime(row[0],'%Y-%m-%d'))
            all_values.append(float(row[1]))

    print(f'Mean:{statistics.mean(all_values)}')