from selenium import webdriver
import os
import mysql.connector
import time

db = mysql.connector.connect(host="IP",
                     user="USER",
                     passwd="PASSWORD",
                     db="license")

cur = db.cursor()

pageinfo = []
driver = webdriver.PhantomJS(service_log_path=os.path.devnull)
driver.get("http://machine:8888/FneServer/manageFeatureUsage_view.action?page=1")

html1 = driver.page_source

os.system("TASKKILL /F /IM phantomjs.exe")

for s in html1.split('<td valign="top">'):
    pageinfo.append(s)
    

usage1 = [int(s) for s in pageinfo[4].split() if s.isdigit()]
usage2 = [int(s) for s in pageinfo[8].split() if s.isdigit()]
usage = usage1[0] + usage2[0]
stringusage = (40 - usage)
a = time.strftime('%Y-%m-%d %H:%M:%S')
cur.execute("INSERT into avidtotal(amount, time) values (" + str(stringusage) + "," + "\"" + a +"\");")
db.commit()
cur.close()
