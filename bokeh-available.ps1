$lines = Get-Content C:\metrics\bokehusage.txt | Measure-Object -Line
$available = 9999 - $lines.Lines | out-file C:\metrics\bokehi-available.txt

$bokehavailable = Get-Content C:\metrics\bokehi-available.txt

$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=5432;Database=licenses;Uid=USERNAME;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE apps SET available ='" + $bokehavailable +"' WHERE product = 'Bokeh (Nuke)'";

$DBCmd.ExecuteReader();
$DBConn.Close();    

$dayhigh = Get-Content C:\dayhigh\bokeh-daily.txt
if ($lines.Lines -gt $dayhigh) {
    remove-item c:\dayhigh\bokeh-daily.txt
    new-item c:\dayhigh\bokeh-daily.txt -type file
    $lines.Lines | out-file c:\dayhigh\bokeh-daily.txt
    }