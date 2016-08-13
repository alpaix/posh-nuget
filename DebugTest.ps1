param (
)

. .\NuGetTabExpansion.ps1

$line = "nuget restore -source nuget.org -configfile .\nu"
$lastWord = ($line -split '\s+')[-1]

$expanded = TabExpansion $line $lastWord
Write-Output $expanded