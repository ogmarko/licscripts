cd "C:\Autodesk\Network License Manager"
./lmutil.exe lmstat -a -f mochapro5 | out-file c:\metrics\temp\mochatemp.txt

get-content C:\metrics\temp\mochatemp.txt | select -skip 32 | out-file c:\metrics\temp\mocha.txt


$contents = Get-Content c:\metrics\temp\mocha.txt # | ? {$_.trim() -ne "" }

remove-item "C:\metrics\temp\mocha1.txt"
new-item C:\metrics\temp\mocha1.txt -type file

foreach($line in $contents) {
    if ($line.Contains('(v5.0)')){
    add-content C:\metrics\temp\mocha1.txt $line
    }
}
$contents = get-content "C:\metrics\temp\mocha1.txt"


remove-item "c:\metrics\mocha-usage.txt"
new-item c:\metrics\mocha-usage.txt -type file


foreach($line in $contents) {
    $s = $line -split " "
    $user = $s[4]
    $pc = $s[5]
    $user + "@" + $pc + " || "| add-content "C:\metrics\mocha-usage.txt"
    }


$mochausage = Get-Content C:\metrics\mocha-usage.txt

$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();

$DBCmd.CommandText = "UPDATE apps SET usage ='" + $mochausage +"' WHERE product = 'Mocha Pro'";

$DBCmd.ExecuteReader();
$DBConn.Close();