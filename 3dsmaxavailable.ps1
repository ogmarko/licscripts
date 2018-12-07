$lines = Get-Content C:\metrics\3dsMax-usage.txt | Measure-Object -Line
$available = #Number - $lines.Lines | out-file C:\metrics\3dsmaxavailable.txt

$3dsmaxavailable = get-content C:\metrics\3dsmaxavailable.txt
$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE apps SET available ='" + $3dsmaxavailable +"' WHERE product = 'M&E Collection' and location = 'CHI'";

$DBCmd.ExecuteReader();
$DBConn.Close();    


$dayhigh = Get-Content C:\dayhigh\autodesk-daily.txt

if ($lines.Lines -gt $dayhigh) {
    print $dayhigh
    remove-item c:\dayhigh\autodesk-daily.txt
    new-item c:\dayhigh\autodesk-daily.txt -type file
    $lines.Lines | out-file c:\dayhigh\autodesk-daily.txt
    }