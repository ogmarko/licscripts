from selenium import webdriver
import os


pageinfo = []
driver = webdriver.PhantomJS(service_log_path=os.path.devnull)
driver.get("http://SERVER:30304/#/bundle/vray30max")

html1 = driver.page_source
os.system("TASKKILL /F /IM phantomjs.exe")

for s in html1.split('<a class="breakdown">'):
    pageinfo.append(s)

        
vrayend = pageinfo[3].index('<')
vray = pageinfo[3][:vrayend]

if str(vray) == '106':
   vray = 4

outfile = open('c:\\metrics\\chivray3ds.txt', 'w')
outfile.write(str(vray))
outfile.close()
