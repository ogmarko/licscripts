cd "C:\Program Files\The Foundry\LicensingTools7.3\bin\RLM"
./rlmutil.exe rlmstat -c "C:\ProgramData\The Foundry\RLM\foundry.lic" -p foundry_production_i v2019.0227 -u | out-file  "c:\metrics\temp\nukepusage_temp.txt"

get-content c:\metrics\temp\nukepusage_temp.txt | select -skip 9 | out-file c:\metrics\temp\nukepusage.txt


$contents = get-content c:\metrics\temp\nukepusage.txt

remove-item "c:\metrics\nukepusage.txt"
new-item c:\metrics\nukepusage.txt -type file


foreach($line in $contents) {
    $s = $line -split " "
    $user = $s[2]
    If (!(Select-String -Path c:\metrics\nukepusage.txt -pattern $user)){$user + " || " | add-content C:\metrics\nukepusage.txt }
  

    }

$nukepusage = Get-Content C:\metrics\nukepusage.txt
$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE combined SET usage ='" + $nukepusage +"' WHERE product = 'Production Suite'";

$DBCmd.ExecuteReader();
$DBConn.Close();    
   