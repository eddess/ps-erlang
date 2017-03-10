@{
# Module info
ModuleVersion = '0.1'
GUID = '1fdef09e-ec47-47fd-a5ed-1f098bde3551'
Description = 'Erlang distribution management utilities'
PowerShellVersion = '5.0'
RootModule = 'ps-erlang.psm1'

Author = 'Eddy Essien'
Copyright = '(c) 2017 Eddy Essien. All rights reserved'

# Exports
FunctionsToExport = @(
    'Show-Erlang', 
    'Show-ErlangReleases',
    'Set-Erlang', 
    'Reset-Erlang'
)

CmdletsToExport = @()
VariablesToExport = @()
AliasesToExport = @()

PrivateData = @{

    PSData = @{
        Tags = @('erlang')
        LicenseUri = 'https://github.com/eddess/ps-erlang/blob/master/LICENSE.txt'
        ProjectUri = 'https://github.com/eddess/ps-erlang'
        # ReleaseNotes = 'https://github.com/eddess/ps-erlang/blob/master/CHANGELOG.md'
        }
    }
}