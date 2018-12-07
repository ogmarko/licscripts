cd "C:\Program Files\Autodesk Network License Manager"
./lmutil.exe lmstat -a -f 85527MAYA_T_F | out-file c:\metrics\temp\mayatemp.txt

$contents = Get-Content c:\metrics\temp\mayatemp.txt # | ? {$_.trim() -ne "" }

remove-item "C:\metrics\temp\maya1.txt"
new-item C:\metrics\temp\maya1.txt -type file

foreach($line in $contents) {
    if ($line.Contains('(v1.000)'){
    add-content C:\metrics\temp\maya1.txt $line
    }
}
$contents = get-content "C:\metrics\temp\maya1.txt"


remove-item "c:\metrics\maya-usage.txt"
new-item c:\metrics\maya-usage.txt -type file


foreach($line in $contents) {
    $s = $line -split " "
    $user = $s[4]
    $pc = $s[5]
    $user + "@" + $pc + " || "| add-content "C:\metrics\maya-usage.txt"
    }


$mayausage = Get-Content C:\metrics\maya-usage.txt

$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();

$DBCmd.CommandText = "UPDATE apps SET usage ='" + $mayausage +"' WHERE product = 'Maya'";

$DBCmd.ExecuteReader();
$DBConn.Close();