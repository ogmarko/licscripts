cd "C:\Program Files\tlm_server-win32-x86-2.6.0\tlm_server-win32-x86-2.6.0\bin\"
.\tlm_server.exe -s | out-file c:\metrics\temp\rvsolo.txt

$contents = get-content "C:\metrics\temp\rvsolo.txt"
$available =7
remove-item "c:\metrics\temp\rvsolo1.txt"
new-item c:\metrics\temp\rvsolo1.txt -type file

foreach($line in $contents) {
    if ($line.Contains('@')){
    add-content C:\metrics\temp\rvsolo1.txt $line
    }
}

$contents = get-content "C:\metrics\temp\rvsolo1.txt"

remove-item "c:\metrics\rvsolo-usage.txt"
new-item c:\metrics\rvsolo-usage.txt -type file

foreach($line in $contents) {
    $s = $line -split " "
    $user = $s[6] + " || "
    add-content C:\metrics\rvsolo-usage.txt $user
    
    }


$rvsolousage = Get-Content C:\metrics\rvsolo-usage.txt

$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE apps SET usage ='" + $rvsolousage +"' WHERE product = 'RV Solo' and location = 'CHI'";
$DBCmd.ExecuteReader();
$DBConn.Close();

