# License scripts


These are the scripts that run every 5 minutes on a network license server and uploads data to a database on a web server to give real time updates on:
1) How many network licenses for a program are available?
2) Who is currently using a network license?

The scripts also keep track of the daily high usage amount for each program by comparing the current usage to the recorded high 
from a text file on the machine.  At the end of a day a script takes all the day high text files and submits it to a Grafana
database that charts the daily high.  This is very useful for end of year license renews as you can see how many of each license 
you actually need.
