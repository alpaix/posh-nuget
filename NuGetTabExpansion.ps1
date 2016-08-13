$NuGetCommands = @(
    'add',
    'config',
    'delete',
    'help',
    'init',
    'install',
    'list',
    'locals',
    'pack',
    'push',
    'restore',
    'setApiKey',
    'sources',
    'spec',
    'update'
)

# usage: NuGet restore [<solution> | <packages.config file> | <project.json> | <Microsoft Build project>] [options]
$RestoreOptionsRaw = @(
    'ConfigFile:file'
    'DisableParallelProcessing:switch'
    'ForceEnglishOutput:switch'
    'Help:switch'
    'MSBuildVersion:value'
    'NoCache:switch'
    'NonInteractive:switch'
    'PackagesDirectory:directory'
    'PackageSaveMode:value'
    'Project2ProjectTimeOut:value'
    'RequireConsent:switch'
    'SolutionDirectory:directory'
    'Verbosity:value'
    'FallbackSource:value+'
    'Source:value+'
)

$RestoreOptions = $RestoreOptionsRaw | %{ ($_ -split ':')[0] }
$RestoreMultipleOptions = $RestoreOptionsRaw | ?{ $_ -like '*+' } | %{ ($_ -split ':')[0] }

if (Test-Path Function:\TabExpansion) {
    Write-Host "rename tab expansion"
    Rename-Item Function:\TabExpansion TabExpansionNext
}

function ExpandRestoreOptions([Object[]]$options, [string]$lastWord) {
    if ($lastWord -and $lastWord -notlike '-*') {
        return ''
    }

    if (-not $options) {
        $availableOptions = $RestoreOptions
    }
    else {
        $usedOptions = $options | %{ $_.Groups[1].Value } | ?{ $RestoreMultipleOptions -notcontains $_ }
        $availableOptions = $RestoreOptions | ?{ $usedOptions -notcontains $_ }
    }

    $all = @(($availableOptions | %{ "-$_"}) -like "$lastWord*") + $lastWord
    return $all
}

$NuGetExePattern = '^([''"]?).*nuget[\.\d-]*(?:\.exe)?\k<1>\s+'
$OptionsPattern = '\s+-(\w+)(?:\s+([^-]\S*))?'

function TabExpansion($line, $lastWord) {

    $matchNuGet = $line | sls -pattern $NuGetExePattern
    if (-not $matchNuGet) {
        return TabExpansionNext $line $lastWord
    }

    $line = $line.Substring($matchNuGet.Matches[0].Length)

    if (-not $line) {
        return $NuGetCommands
    }

    if ($line -eq $lastWord) {
        return @($NuGetCommands -like "${lastWord}*") + $lastWord | select -Unique
    }

    $opts = $line | sls -pattern $OptionsPattern -AllMatches | %{ $_.Matches }

    if ($opts) {
       $pos = $line.Substring(0, $opts[0].Index)
    }
    else {
        $pos = $line
    }

    $matchCmd = ($pos -split '\s+')[0]

    switch ($matchCmd) {
        'restore' {
            $expanded = ExpandRestoreOptions $opts $lastWord
         }
    }

    if (-not $expanded) {
        return TabExpansionNext $line $lastWord
    }

    return $expanded
}