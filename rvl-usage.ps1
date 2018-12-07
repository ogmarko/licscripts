cd "C:\Program Files (x86)\REVisionEffects\bin"
./rvlstatus.exe | out-file c:\metrics\temp\rvlusagetemp.txt

get-content C:\metrics\temp\rvlusagetemp.txt | select -skip 15 | out-file C:\metrics\temp\rvlusagetemp1.txt

remove-item "c:\metrics\rvlusage.txt"
new-item c:\metrics\rvlusage.txt -type file

$contents = get-content "C:\metrics\temp\rvlusagetemp1.txt" | ? {$_.trim() -ne "" }
DO
{
    foreach($line in $contents) {
   
        if($line -ne "License #2"){
        $s = $line -split " "
        $ipaddr = $s[17]
        $pcname = $s[18]
        $pcname + "@" + $ipaddr + " || " | add-content "C:\metrics\rvlusage.txt"
        }
        else {break}
    }
}
    while($line -ne "License #2")



$rvlusage = Get-Content C:\metrics\rvlusage.txt
$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE apps SET usage ='" + $rvlusage +"' WHERE product = 'reelsmartmotionblur' and location = 'CHI'";

$DBCmd.ExecuteReader();
$DBConn.Close();    
   