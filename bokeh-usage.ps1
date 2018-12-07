cd "c:\Program Files (x86)\peregrine"
./rlmutil rlmstat -c "c:\Program Files (x86)\peregrine\peregrinel_carbonvfx_12916_220819.lic" -p bokeh_i -u | out-file  "c:\metrics\temp\bokehusage_temp.txt"

get-content c:\metrics\temp\bokehusage_temp.txt | select -skip 9 | out-file c:\metrics\temp\bokehusage.txt


$contents = get-content c:\metrics\temp\bokehusage.txt

remove-item "c:\metrics\bokehusage.txt"
new-item c:\metrics\bokehusage.txt -type file


foreach($line in $contents) {
    $s = $line -split " "
    $user = $s[2]
    If (!(Select-String -Path c:\metrics\bokehusage.txt -pattern $user)){$user + " || " | add-content C:\metrics\bokehusage.txt }
  

    }

$bokehusage = Get-Content C:\metrics\bokehusage.txt
$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE apps SET usage ='" + $bokehusage +"' WHERE product = 'Bokeh (Nuke)'";

$DBCmd.ExecuteReader();
$DBConn.Close();    
   