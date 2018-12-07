from selenium import webdriver
import os
import mysql.connector
import time

db = mysql.connector.connect(host="IP",
                     user="USER",
                     passwd="PASSWORD",
                     db="license")

cur = db.cursor()

x = 0
locationpageinfo = []
locationusage = []

driver = webdriver.PhantomJS(service_log_path=os.path.devnull)
driver.get("http://SERVER:8888/FneServer/manageDevices_view.action?page=1")

html1 = driver.page_source

os.system("TASKKILL /F /IM phantomjs.exe")

locationusage = html1.count('location-')
capusage = html1.count('LOCATION-')

totallocationusage = (int(locationusage) + int(capusage)) / 2
print(totallocationusage)

a = time.strftime('%Y-%m-%d %H:%M:%S')
cur.execute("INSERT into avidlocation(amount, time) values (" + str(totallocationusage) + "," + "\"" + a +"\");")
db.commit()
cur.close()
