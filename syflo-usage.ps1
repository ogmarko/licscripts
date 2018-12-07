cd "C:\Program Files\Andersson Technologies LLC\SynthEyes"
./syflo.exe -list | out-file C:\metrics\temp\syflotemp.txt

remove-item "c:\metrics\temp\syflousage.txt"
new-item c:\metrics\temp\syflousage.txt -type file


$contents = Get-Content C:\metrics\temp\syflotemp.txt
foreach($line in $contents){
    if ($line.Contains('FL-1803')){
	$s = $line -split " "
	$user = $s[13]
	$pc = $s[7]
	$user + "@" + $pc + " || " |add-content c:\metrics\temp\syflousage.txt
}
}

get-content c:\metrics\temp\syflousage.txt | ? {$_.trim() -ne "-----@----- ||"} | out-file c:\metrics\temp\syflousage1.txt
get-content c:\metrics\temp\syflousage1.txt | ? {$_.trim() -ne "@----- ||"} | out-file c:\metrics\syflousage.txt


$syflousage = Get-Content C:\metrics\syflousage.txt
$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=10.20.1.200;Port=5432;Database=licenses;Uid=carbon;Pwd=Mn20d#fw01;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE apps SET usage ='" + $syflousage +"' WHERE product = 'SynthEyes'";

$DBCmd.ExecuteReader();
$DBConn.Close();    