cd "C:\Program Files (x86)\GenArts\rlm"
./rlmutil rlmstat -c "C:\Program Files (x86)\GenArts\rlm\genarts.lic" -p sapphire_ae_ofx_sparks_102f v20160901 -u | out-file  "c:\metrics\temp\sapphireusage_temp.txt"

get-content c:\metrics\temp\sapphireusage_temp.txt | select -skip 9 | out-file c:\metrics\temp\sapphireusage.txt


$contents = get-content c:\metrics\temp\sapphireusage.txt

remove-item "c:\metrics\sapphireusage.txt"
new-item c:\metrics\sapphireusage.txt -type file


foreach($line in $contents) {
    $s = $line -split " "
    $user = $s[2] 
    If (!(Select-String -Path c:\metrics\sapphireusage.txt -pattern $user)){$user + " ||"| add-content C:\metrics\sapphireusage.txt }
  

    }

$sapphireusage = Get-Content C:\metrics\sapphireusage.txt
$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE apps SET usage ='" + $sapphireusage +"' WHERE product = 'Sapphire' and location";

$DBCmd.ExecuteReader();
$DBConn.Close();   