cd "C:\Autodesk\Network License Manager"
./lmutil.exe lmstat -a -f 86985ARNOL_T_F | out-file c:\metrics\temp\arnoldtemp.txt

#get-content C:\metrics\temp\arnoldtemp.txt | select -skip 32 | out-file c:\metrics\temp\arnold.txt


$contents = Get-Content c:\metrics\temp\arnoldtemp.txt # | ? {$_.trim() -ne "" }

remove-item "C:\metrics\temp\arnold1.txt"
new-item C:\metrics\temp\arnold1.txt -type file

foreach($line in $contents) {
    if ($line.Contains('(v1.000)'){
    add-content C:\metrics\temp\arnold1.txt $line
    }
}
$contents = get-content "C:\metrics\temp\arnold1.txt"


remove-item "c:\metrics\arnold-usage.txt"
new-item c:\metrics\arnold-usage.txt -type file


foreach($line in $contents) {
    $s = $line -split " "
    $user = $s[4]
    $pc = $s[5]
    $user + "@" + $pc + " || "| add-content "C:\metrics\arnold-usage.txt"
    }


$arnoldusage = Get-Content C:\metrics\arnold-usage.txt

$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();

$DBCmd.CommandText = "UPDATE apps SET usage ='" + $arnoldusage +"' WHERE product = 'Arnold'";

$DBCmd.ExecuteReader();
$DBConn.Close();