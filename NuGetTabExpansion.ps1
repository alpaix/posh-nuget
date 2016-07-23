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
    '-RequireConsent'
    '-Project2ProjectTimeOut'
    '-PackagesDirectory'
    '-SolutionDirectory'
    '-MSBuildVersion'
    '-Source +'
    '-FallbackSource +'
    '-NoCache'
    '-DisableParallelProcessing'
    '-PackageSaveMode'
    '-Help'
    '-Verbosity'
    '-NonInteractive'
    '-ConfigFile'
    '-ForceEnglishOutput'
)

if (Test-Path Function:\TabExpansion) {
    Write-Host "rename tab expansion"
    Rename-Item Function:\TabExpansion TabExpansionNext
}

function ExpandRestoreOptions($tokens) {
    $RestoreOptions
}

$NuGetExePattern = '^[''"]?.*nuget[\.\d-]*(?:\.exe)?[''"]?\s+(\w+)?'
$OptionsPattern = '\s+(-\w+)(\s+[^-][^\s]+)?'

function TabExpansion($line, $lastWord) {

    $matchNuGet = $line | sls -pattern $NuGetExePattern
    if (-not $matchNuGet) {
        return 'pizzda'
        #return TabExpansionNext $line $lastWord
    }

    $matchCmd = $matchNuGet.Matches.Groups[-1]

    if ($matchNuGet.Matches.Groups[0].Length -eq $line.Length) {

        if (-not $matchCmd.Success) {
            return $NuGetCommands
        }

        return $NuGetCommands -like "$($matchCmd.Value)*"
    }

    $from = $matchCmd.Index + $matchCmd.Length
    $args = $line.Substring($from)

    if (-not $args) {
        return $RestoreOptions
    }

    $opts = $args | sls -pattern $OptionsPattern -AllMatches | %{ $_.Matches } | %{ $_.Value }
    return $opts
<#
    switch ($matchCmd.Value) {
        'restore' {
            return ExpandRestoreOptions $tokens[2..($tokens.Count-1)]
         }
        Default {
            return TabExpansionNext $line $lastWord
        }
    }
    return TabExpansionNext $line $lastWord
#>
}