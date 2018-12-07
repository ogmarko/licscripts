cd "C:\Program Files (x86)\GenArts\rlm"
./rlmutil rlmstat -c "C:\Program Files (x86)\GenArts\rlm\RedGiant-RLM-b2806ce1-5f25-451b-9972-c17db3fc2188.lic" -p effectssuite v999.9 -u | out-file  "c:\metrics\temp\effectssuiteusage_temp.txt"

get-content c:\metrics\temp\effectssuiteusage_temp.txt | select -skip 9 | out-file c:\metrics\temp\effectssuiteusage.txt


$contents = get-content c:\metrics\temp\effectssuiteusage.txt | ? {$_.trim() -ne "" }

remove-item "c:\metrics\effectssuiteusage.txt"
new-item c:\metrics\effectssuiteusage.txt -type file


foreach($line in $contents) {
    $s = $line -split " "
    $user = $s[2] + " || "
  If (!(Select-String -Path c:\metrics\effectssuiteusage.txt -pattern $user)){$user | add-content C:\metrics\effectssuiteusage.txt }
  #  $user | add-content "C:\metrics\effectssuiteusage.txt"

    }

$effectsusage = get-content C:\metrics\effectssuiteusage.txt
$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE combined SET usage ='" + $effectsusage +"' WHERE product = 'Effects Suite'";
$DBCmd.ExecuteReader();
$DBConn.Close();
