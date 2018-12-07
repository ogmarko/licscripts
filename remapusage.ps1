cd "C:\Program Files (x86)\REVisionEffects\bin"
./rvlstatus.exe | out-file c:\metrics\temp\remapusagetemp.txt


$lastline = Get-Content "c:\metrics\temp\remapusagetemp.txt" | ? {$_.trim() -ne "" } | select -Last 1 | out-file C:\metrics\temp\rmaptemp.txt

$lastline1 = Get-Content c:\metrics\temp\rmaptemp.txt
remove-item "c:\metrics\remapusage.txt"
new-item c:\metrics\remapusage.txt -type file
if($lastline1 -ne "Current clients: 0"){
  $s = $lastline1 -split " "
  $ipaddr = $s[17]
  $pcname = $s[18]
  $pcname + "@" + $ipaddr + " || " | out-file "C:\metrics\remapusage.txt"
   }

$remapusage = Get-Content C:\metrics\remapusage.txt
$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE apps SET usage ='" + $remapusage +"' WHERE product = 'RE:Map'";

$DBCmd.ExecuteReader();
$DBConn.Close();    
   