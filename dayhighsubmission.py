import os
import mysql.connector
import time

db = mysql.connector.connect(host="IP",
                     user="USER",
                     passwd="Password",
                     db="license")

cur = db.cursor()
with open ("c:\\dayhigh\\PROGRAM-daily.txt", "rb") as myfile:
	PROGRAM=myfile.readlines()
myfile.close()


PROGRAM1 = PROGRAM[0].decode(errors='ignore')

PROGRAM = ''.join(e for e in PROGRAM1 if e.isalnum())


a = time.strftime('%Y-%m-%d %H:%M:%S')
cur.execute("INSERT into PROGRAM(amount, time) values (" + PROGRAM + "," + "\"" + a +"\");")
db.commit()
cur.close()


