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

$CommonOptionsRaw = @(
    'ConfigFile:file' # The NuGet configuration file. If not specified, file %AppData%\NuGet\NuGet.config is used as configuration file.
    'ForceEnglishOutput:switch' # Forces the application to run using an invariant, English-based culture.
    'Help:switch' # help
    'NonInteractive:switch' # Do not prompt for user input or confirmations.
    'Verbosity:value' # Display this amount of details in the output: normal, quiet, detailed.
)

# usage: NuGet add <packagePath> -Source <folderBasedPackageSource> [options]
$AddOptionsRaw = @(
    'Expand:switch' # If provided, a package added to offline feed is also expanded.
    'Source:value' # Specifies the package source, which is a folder or UNC share, to which the nupkg will be added. Http sources are not supported.
) + $CommonOptionsRaw

# usage: NuGet config <-Set name=value | name>
$ConfigOptionsRaw = @(
    'AsPath:value' # Returns the config value as a path. This option is ignored when -Set is specified.
    'Set:value+' # One on more key-value pairs to be set in config.
) + $CommonOptionsRaw

# usage: NuGet delete <package Id> <package version> [API Key] [options]
$DeleteOptionsRaw = @(
    'ApiKey:value' # The API key for the server.
    'NoPrompt:switch' # Do not prompt when deleting.
    'Source:value' # Specifies the server URL.
) + $CommonOptionsRaw

# usage: NuGet help [command]
$HelpOptionsRaw = @(
    'All:switch' # Print detailed help for all available commands.
    'Markdown:switch' # Print detailed all help in markdown format.
) + $CommonOptionsRaw

# usage: NuGet init <srcPackageSourcePath> <destPackageSourcePath> [options]
$InitOptionsRaw = @(
    'Expand:switch' # If provided, a package added to offline feed is also expanded.
) + $CommonOptionsRaw

# usage: NuGet install packageId|pathToPackagesConfig [options]
$InstallOptionsRaw = @(
    'DisableParallelProcessing:switch' # Disable parallel processing of packages for this command.
    'ExcludeVersion:switch' # If set, the destination folder will contain only the package name, not the version number
    'FallbackSource:value+' # A list of package sources to use as fallbacks for this command.
    'NoCache:switch' # Disable using the machine cache as the first package source.
    'OutputDirectory:directory' # Specifies the directory in which packages will be installed. If none specified, uses the current directory.
    'PackageSaveMode:value' # Specifies types of files to save after package installation: nuspec, nupkg, nuspec;nupkg.
    'Prerelease:switch' # Allows prerelease packages to be installed. This flag is not required when restoring packages by installing from packages.config.
    'RequireConsent:switch' # Checks if package restore consent is granted before installing a package.
    'SolutionDirectory:directory' # Solution root for package restore.
    'Source:value+' # A list of packages sources to use for this command.
    'Version:value' # The version of the package to install.
) + $CommonOptionsRaw

# usage: NuGet list [search terms] [options]
$ListOptionsRaw = @(
    'AllVersions:switch' # List all versions of a package. By default, only the latest package version is displayed.
    'IncludeDelisted:switch' # Allow unlisted packages to be shown.
    'Prerelease:switch' # Allow prerelease packages to be shown.
    'Source:value+' # A list of packages sources to search.
    'Verbose:switch' # Displays a detailed list of information for each package.
) + $CommonOptionsRaw

# usage: NuGet locals <all | http-cache | packages-cache | global-packages | temp> [-clear | -list]
$LocalsOptionsRaw = @(
    'Clear:switch' # Clear the selected local resources or cache location(s).
    'List:switch' # List the selected local resources or cache location(s).
) + $CommonOptionsRaw

# usage: NuGet pack <nuspec | project> [options]
$PackOptionsRaw = @(
    'BasePath:directory' # The base path of the files defined in the nuspec file.
    'Build:switch' # Determines if the project should be built before building the package.
    'Exclude:value+' # Specifies one or more wildcard patterns to exclude when creating a package.
    'ExcludeEmptyDirectories:switch' # Prevent inclusion of empty directories when building the package.
    'IncludeReferencedProjects:switch' # Include referenced projects either as dependencies or as part of the package.
    'MinClientVersion:value' # Set the minClientVersion attribute for the created package.
    'MSBuildVersion:value' # Specifies the version of MSBuild to be used with this command. Supported values are 4, 12, 14. By default the MSBuild in your path is picked, otherwise it defaults to the h
    'NoDefaultExcludes:switch' # Prevent default exclusion of NuGet package files and files and folders starting with a dot e.g. .svn.
    'NoPackageAnalysis:switch' # Specify if the command should not run package analysis after building the package.
    'OutputDirectory:directory' # Specifies the directory for the created NuGet package file. If not specified, uses the current directory.
    'Properties:value+' # Provides the ability to specify a semicolon ";" delimited list of properties when creating a package.
    'Suffix:switch' # Appends a pre-release suffix to the internally generated version number.
    'Symbols:switch' # Determines if a package containing sources and symbols should be created. When specified with a nuspec, creates a regular NuGet package file and the corresponding symbols p
    'Tool:switch' # Determines if the output files of the project should be in the tool folder.
    'Version:value' # Overrides the version number from the nuspec file.
) + $CommonOptionsRaw

# usage: NuGet push <package path> [API key] [options]
$PushOptionsRaw = @(
    'ApiKey:value' # The API key for the server.
    'DisableBuffering:switch' # Disable buffering when pushing to an HTTP(S) server to decrease memory usage. Note that when this option is enabled, integrated windows authentication might not work.
    'NoSymbols:switch' # If a symbols package exists, it will not be pushed to a symbols server.
    'Source:value' # Specifies the server URL. If not specified, nuget.org is used unless DefaultPushSource config value is set in the NuGet config file.
    'Timeout:value' # Specifies the timeout for pushing to a server in seconds. Defaults to 300 seconds (5 minutes).
) + $CommonOptionsRaw

# usage: NuGet restore [<solution> | <packages.config file> | <project.json> | <Microsoft Build project>] [options]
$RestoreOptionsRaw = @(
    'DisableParallelProcessing:switch' # Disable parallel processing of packages for this command.
    'FallbackSource:value+' # A list of package sources to use as fallbacks for this command.
    'MSBuildVersion:value' # Specifies the version of MSBuild to be used with this command. Supported values are 4, 12, 14. By default the MSBuild in your path is picked, otherwise it def
    'NoCache:switch' # Disable using the machine cache as the first package source.
    'PackageSaveMode:value' # Specifies types of files to save after package installation: nuspec, nupkg, nuspec;nupkg.
    'PackagesDirectory:directory' # Specifies the packages folder.
    'Project2ProjectTimeOut:value' # Timeout in seconds for resolving project to project references.
    'RequireConsent:switch' # Checks if package restore consent is granted before installing a package.
    'SolutionDirectory:directory' # Specifies the solution directory. Not valid when restoring packages for a solution.
    'Source:value+' # A list of packages sources to use for this command.
) + $CommonOptionsRaw

# usage: NuGet setApiKey <API key> [options]
$SetApiKeyOptionsRaw = @(
    'Source:value' # Server URL where the API key is valid.
) + $CommonOptionsRaw

# usage: NuGet sources <List|Add|Remove|Enable|Disable|Update> -Name [name] -Source [source]
$SourcesOptionsRaw = @(
    'Format:value' # Applies to the list action. Accepts two values: Detailed (the default) and Short.
    'Name:value' # Name of the source.
    'Password:value' # Password to be used when connecting to an authenticated source.
    'Source:value' # Path to the package(s) source.
    'StorePasswordInClearText:switch' # Enables storing portable package source credentials by disabling password encryption.
    'UserName:value' # UserName to be used when connecting to an authenticated source.
) + $CommonOptionsRaw

# usage: NuGet spec [package id]
$SpecOptionsRaw = @(
    'AssemblyPath:path' # Assembly to use for metadata.
    'Force:switch' # Overwrite nuspec file if it exists.
) + $CommonOptionsRaw

# usage: NuGet update <packages.config|solution|project>
$UpdateOptionsRaw = @(
    'FileConflictAction:value' # Set default action when a file from a package already exists in the target project. Set to Overwrite to always overwrite files. Set to Ignore to skip files. If not specified, it w
    'Id:value+' # Package ids to update.
    'MSBuildVersion:value' # Specifies the version of MSBuild to be used with this command. Supported values are 4, 12, 14. By default the MSBuild in your path is picked, otherwise it defaults to the highest
    'Prerelease:switch' # Allows updating to prerelease versions. This flag is not required when updating prerelease packages that are already installed.
    'RepositoryPath:path' # Path to the local packages folder (location where packages are installed).
    'Safe:switch' # Looks for updates with the highest version available within the same major and minor version as the installed package.
    'Self:switch' # Update the running NuGet.exe to the newest version available from the server.
    'Source:value+' # A list of package sources to search for updates.
    'Verbose:switch' # Show verbose output while updating.
    'Version:value' # Updates the package in -Id to the version indicated.  Requires -Id to contain exactly one package id.
) + $CommonOptionsRaw

if (Test-Path Function:\TabExpansion) {
    Write-Host "rename tab expansion"
    Rename-Item Function:\TabExpansion TabExpansionNext
}

function ExpandCommandOptions {
    param(
        [string[]]$RawOptions,
        [Object[]]$OptionGroups,
        [string]$LastWord)

    if ($lastWord -and $lastWord -notlike '-*') {
        return ''
    }

    $RestoreOptions = $RawOptions | %{ ($_ -split ':')[0] }
    $RestoreMultipleOptions = $RawOptions | ?{ $_ -like '*+' } | %{ ($_ -split ':')[0] }

    if (-not $OptionGroups) {
        $availableOptions = $RestoreOptions
    }
    else {
        $usedOptions = $OptionGroups | %{ $_.Groups[1].Value } | ?{ $RestoreMultipleOptions -notcontains $_ }
        $availableOptions = $RestoreOptions | ?{ $usedOptions -notcontains $_ }
    }

    $all = @(($availableOptions | %{ "-$_" }) -like "$lastWord*") + $lastWord
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

    $expanded = switch ($matchCmd) {
         'add' {
            ExpandCommandOptions $AddOptionsRaw $opts $lastWord
         }
        'config' {
            ExpandCommandOptions $ConfigOptionsRaw $opts $lastWord
         }
        'delete' {
            ExpandCommandOptions $DeleteOptionsRaw $opts $lastWord
         }
        'help' {
            ExpandCommandOptions $HelpOptionsRaw $opts $lastWord
         }
        'init' {
            ExpandCommandOptions $InitOptionsRaw $opts $lastWord
         }
        'install' {
            ExpandCommandOptions $InstallOptionsRaw $opts $lastWord
         }
        'list' {
            ExpandCommandOptions $ListOptionsRaw $opts $lastWord
         }
        'locals' {
            ExpandCommandOptions $LocalsOptionsRaw $opts $lastWord
         }
        'pack' {
            ExpandCommandOptions $PackOptionsRaw $opts $lastWord
         }
        'push' {
            ExpandCommandOptions $PushOptionsRaw $opts $lastWord
         }
        'restore' {
            ExpandCommandOptions $RestoreOptionsRaw $opts $lastWord
         }
        'setApiKey' {
            ExpandCommandOptions $SetApiKeyOptionsRaw $opts $lastWord
         }
        'sources' {
            ExpandCommandOptions $SourcesOptionsRaw $opts $lastWord
         }
        'spec' {
            ExpandCommandOptions $SpecOptionsRaw $opts $lastWord
         }
        'update' {
            ExpandCommandOptions $UpdateOptionsRaw $opts $lastWord
         }
    }

    if (-not $expanded) {
        return TabExpansionNext $line $lastWord
    }

    return $expanded
}