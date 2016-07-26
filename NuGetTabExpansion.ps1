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
$RestoreOptions = @(
    'RequireConsent'
    'Project2ProjectTimeOut'
    'PackagesDirectory'
    'SolutionDirectory'
    'MSBuildVersion'
    'Source +'
    'FallbackSource +'
    'NoCache'
    'DisableParallelProcessing'
    'PackageSaveMode'
    'Help'
    'Verbosity'
    'NonInteractive'
    'ConfigFile'
    'ForceEnglishOutput'
)

if (Test-Path Function:\TabExpansion) {
    Write-Host "rename tab expansion"
    Rename-Item Function:\TabExpansion TabExpansionNext
}

function ExpandRestoreOptions([string[]]$usedOptions, $lastWord) {
    if (-not $lastWord) {
        return $RestoreOptions | ?{ $usedOptions -notcontains $_ } | %{ "-$_"}
    }
    if ($lastWord -like '-*') {
        return ($RestoreOptions | ?{ $usedOptions -notcontains $_ } | %{ "-$_"}) -like "$lastWord*"
    }

    return 'xui'
}

$NuGetExePattern = '^([''"]?).*nuget[\.\d-]*(?:\.exe)?\k<1>\s+'
$OptionsPattern = '\s+-(\w+)(\s+[^-][^\s]+)?'

function TabExpansion($line, $lastWord) {

    $matchNuGet = $line | sls -pattern $NuGetExePattern
    if (-not $matchNuGet) {
        return 'pizzda'
        #return TabExpansionNext $line $lastWord
    }

    $line = $line.Substring($matchNuGet.Matches[0].Length)

    if (-not $line) {
        return $NuGetCommands
    }

    if ($line -eq $lastWord) {
        return ($NuGetCommands -like "${lastWord}*") + @($lastWord) | select -Unique
    }

    $matchOpts = $line | sls -pattern $OptionsPattern -AllMatches | %{ $_.Matches }
    $opts = $matchOpts | %{ $_.Groups[1].Value }

    if ($matchOpts) {
       $pos = $line.Substring(0, $matchOpts[0].Index)
    }
    else {
        $pos = $line
    }

    $matchCmd = $pos | sls -pattern '\w+' | %{ $_.Matches } | select -first 1

    switch ($matchCmd.Value) {
        'restore' {
            return ExpandRestoreOptions $opts $lastWord
         }
        Default {
            return TabExpansionNext $line $lastWord
        }
    }

    #return TabExpansionNext $line $lastWord
    return 'pizdets'
}