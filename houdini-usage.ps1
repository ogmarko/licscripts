cd "C:\Program Files\Side Effects Software\Houdini 16.0.450\bin"
.\sesictrl.exe -i | Select-String -Pattern "Houdini-Master 16.5" -Context 0,1| out-file c:\metrics\temp\houdini.txt


$contents = get-content "C:\metrics\temp\houdini.txt"
remove-item "c:\metrics\temp\houdini1.txt"
new-item c:\metrics\temp\houdini1.txt -type file

foreach($line in $contents) {
    if ($line.Contains('@')){
    add-content C:\metrics\temp\houdini1.txt $line
    }
}

$contents = get-content "C:\metrics\temp\houdini1.txt"

remove-item "c:\metrics\houdini-usage.txt"
new-item c:\metrics\houdini-usage.txt -type file

foreach($line in $contents) {
    $s = $line -split " "
        foreach($word in $s){
        if ($word.Contains('@')){
 			$word + " || " | add-content "C:\metrics\houdini-usage.txt"
    }}}


$houdiniusage = Get-Content C:\metrics\houdini-usage.txt
$houdiniavailable = Get-Content C:\metrics\houdiniavailable.txt
$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE combined SET usage ='" + $houdiniusage +"' WHERE product = 'Houdini FX'";

$DBCmd.ExecuteReader();
$DBConn.Close();    





   