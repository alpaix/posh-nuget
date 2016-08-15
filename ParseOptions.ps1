[CmdletBinding()]
param(
    [Parameter(ValueFromPipeline=$True)]
    [string[]]$HelpOutputLines
)
Begin {
    $UsagePattern = "^usage: NuGet (\w+) .*$"
    $OptionHelpPattern = "^ -(\w+)\s+(?:\(\S+\)\s+)?(.+)$"
    $Lines = @()
}
Process {
    $Lines += $HelpOutputLines | ?{ $_ }
}
End {
    $Lines | sls -Pattern $UsagePattern | %{ $_.Matches } | %{
        "# $($_.Groups[0].Value)"
        "`$$($_.Groups[1].Value)OptionsRaw = @("
    }
    $Lines | sort | sls -Pattern $OptionHelpPattern | %{ $_.Matches } | ?{
        'ConfigFile', 'ForceEnglishOutput', 'Help', 'NonInteractive', 'Verbosity' -notcontains $_.Groups[1].Value
    } | %{
        "    '$($_.Groups[1].Value):' # $($_.Groups[2].Value)"
    }
    Write-Output ") + `$CommonOptionsRaw"
}