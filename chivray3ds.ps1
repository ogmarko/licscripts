$chivray3ds = get-content C:\metrics\chivray3ds.txt
$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE apps SET available ='" + $chivray3ds +"' WHERE product = 'V-Ray for 3DS Max'";

$DBCmd.ExecuteReader();
$DBConn.Close();    

$chihigh = 4 - $chivray3ds
$dayhigh = Get-Content C:\dayhigh\chivray3ds.txt
if ($chihigh -gt $dayhigh) {
    remove-item c:\dayhigh\chivray3ds.txt
    new-item c:\dayhigh\chivray3ds.txt -type file
    $chihigh | out-file c:\dayhigh\chivray3ds.txt
    }