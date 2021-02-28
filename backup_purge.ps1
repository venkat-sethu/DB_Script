$timespan = new-timespan -days 14
$path = "C:\Backup1"
#below will check if the backup is taken before N days and will make sure that latest two backups will not be deleted eventhough it is N days old

foreach ($report in Get-ChildItem -Path $path  -File |where { $_.Name -like 'DBNAME*.bak' }| Sort-Object -Property LastWriteTime -Descending | Get-ChildItem -Name | Select-Object -Skip 2)
{
$lastWrite = (get-item $report).LastWriteTime
  if(((get-date) - $lastWrite) -gt $timespan) {
   Remove-Item $report
} else {
    Write-Output "$report is not older than 14 days"
}
}
