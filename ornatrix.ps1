cd C:\licscripts
.\Ephere.Licensing.LicenseServer.Manager.exe 127.0.0.1 ephere.plugins.autodesk.maya.ornatrix.2 /available | out-file c:\metrics\ornatrixusage.txt

$ornatrix = get-content c:\metrics\ornatrixusage.txt
$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE apps SET available ='" + $ornatrix +"' WHERE product = 'Ornatrix For Maya'";

$DBCmd.ExecuteReader();
$DBConn.Close();  

$dayhigh = Get-Content C:\dayhigh\ornatrix-daily.txt
$current = 4 - $ornatrix
$current
if ($current -gt $dayhigh) {
    remove-item c:\dayhigh\ornatrix-daily.txt
    new-item c:\dayhigh\ornatrix-daily.txt -type file
    $current | out-file c:\dayhigh\ornatrix-daily.txt
    }