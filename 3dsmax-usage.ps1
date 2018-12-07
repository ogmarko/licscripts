cd "C:\Autodesk\Network License Manager"
./lmutil.exe lmstat -a -f 85807ENCSU_F | out-file c:\metrics\temp\EntertainmentCStemp.txt

#get-content C:\metrics\temp\EntertainmentCStemp.txt | select -skip 32| out-file c:\metrics\temp\EntertainmentCS.txt

./lmutil.exe lmstat -a -f 86828MECOLL_T_F | out-file c:\metrics\temp\MEcollectiontemp.txt

#get-content C:\metrics\temp\MEcollectiontemp.txt | select -skip 32| out-file c:\metrics\temp\MEcollection.txt

$contents = Get-Content c:\metrics\temp\EntertainmentCStemp.txt  | ? {$_.trim() -ne "" }
remove-item "C:\metrics\temp\3dsmax1.txt"
new-item C:\metrics\temp\3dsmax1.txt -type file

foreach($line in $contents) {
    if ($line.Contains('(v1.000)')){
    add-content C:\metrics\temp\3dsmax1.txt $line
    }
}


remove-item "c:\metrics\3dsMax-usage.txt"
new-item c:\metrics\3dsMax-usage.txt -type file


$contents = Get-Content c:\metrics\temp\MEcollectiontemp.txt | ? {$_.trim() -ne "" }
foreach($line in $contents) {
    if ($line.Contains('(v1.000)')){
    add-content C:\metrics\temp\3dsmax1.txt $line
    }
}

$contents = get-content "C:\metrics\temp\3dsmax1.txt"
foreach($line in $contents) {
    $s = $line -split " "
    $user = $s[4]
    $pc = $s[5]
    $user + "@" + $pc + " " + " || " | add-content "C:\metrics\3dsMax-usage.txt"
   
    }
 

$3dsmaxusage = get-content C:\metrics\3dsMax-usage.txt

$DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=IP;Port=PORT;Database=licenses;Uid=USER;Pwd=PASSWORD;"
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "UPDATE apps SET usage ='" + $3dsmaxusage +"' WHERE product = 'M&E Collection'";

$DBCmd.ExecuteReader();
$DBConn.Close();