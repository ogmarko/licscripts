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
respageinfo = []
resusage = []

driver = webdriver.PhantomJS(service_log_path=os.path.devnull)
driver.get("http://machine:8888/FneServer/manageReservations_view.action;jsessionid=C418D852835D8AA8669807BB0D6F3D82?page=1")

reservation = driver.page_source

os.system("TASKKILL /F /IM phantomjs.exe")

usage = reservation.count("accept24.gif") - 1

a = time.strftime('%Y-%m-%d %H:%M:%S')
cur.execute("INSERT into avidres(amount, time) values (" + str(usage) + "," + "\"" + a +"\");")
db.commit()
cur.close()
