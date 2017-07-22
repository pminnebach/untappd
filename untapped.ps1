#!/usr/bin/env powershell
$beer = Get-Content -Path ./checkin-report_*.json | ConvertFrom-Json

Write-Host "Total Checkins: "-ForegroundColor Red
Write-Host ($beer | Measure-Object).Count`n

Write-Host "5 most popular beers:" -ForegroundColor Red
$beer | Group-Object -Property beer_name | Sort-Object count -Descending | Select-Object name, count -First 5 | Format-Table -AutoSize

Write-Host "5 most popular breweries:" -ForegroundColor Red
$beer | Group-Object -Property brewery_name | Sort-Object count -Descending | Select-Object name, count -First 5| Format-Table -AutoSize

Write-Host "5 most popular beer styles:" -ForegroundColor Red
$beer | Group-Object -Property beer_type | Sort-Object count -Descending | Select-Object name, count -First 5| Format-Table -AutoSize

Write-Host "5 beers with highest abv:" -ForegroundColor Red
$beer | select @{n="Name"; e={$_.beer_name}}, @{n="abv"; e={$_.beer_abv.todouble($null)}} -Unique | Sort-Object abv -Descending | Select-Object Name, abv -First 5 | Format-Table -AutoSize

Write-Host "5 most popular venues:" -ForegroundColor Red
$beer | Group-Object -Property venue_name | Sort-Object count -Descending | Select-Object name, count -First 5| Format-Table -AutoSize
