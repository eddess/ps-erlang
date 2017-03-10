# Variables hash
$erlang = @{}

# Erlang Installations Directory
if ( Test-Path Env:erlang_root ) {
    $erlang.root = $Env:erlang_root 
} else {
    $erlang.root = 'C:\Lang\Erlang'
}

$erlang.builds = [io.path]::Combine($erlang.root, 'builds')
$erlang.installs = [io.path]::Combine($erlang.root, 'installs')

# Currently activated version
$erlang.active = ''

# Download URI
$erlang.download_uri = "http://erlang.org/download/"
$erlang.download_prefix = "otp_win"

# Source helper modules
. $PSScriptRoot\show-erlang.ps1


<#
    .Synopsis
        Sets the active Erlang installation for this session

    .Description
        Sets the active Erlang installation for this session. Succeeds if the installation
        exists. Fails otherwise.

    .Parameter version
        A string representing the version of Erlang to activate
#>
function Set-Erlang {
    Param(
        [Parameter(Position=0, HelpMessage='The installation to activate.', Mandatory=$true)]
        [Alias('v')]
        [string]
        $version
    )

    if ( -Not ((Get-ChildItem -Directory  $erlang.installs).Name -contains $version)) {
        Throw $version + ' is not an available installation'
    }

    Reset-Erlang | Out-Null

    $erlang.active = $version
    $erlang.active_path = [io.path]::Combine($erlang.root, $version, 'bin')
    $env:Path += ';' + $erlang.active_path

    Write-Output 'Successfully activated' $version
}

<#
    .Synopsis
        Deactivates any set Erlang installation

    .Description
        Deactivates any set Erlang installation. 
#>
function Reset-Erlang {
    if ( -Not $erlang.active ) {
        Write-Output 'No active installation in this session'
        return
    }

    # Remove from path
    $env:Path = (($env:Path.Split(';') | Where-Object { $_ -ne $erlang.active_path }) -join ';')

    $erlang.active = ''
    $erlang.active_path = ''

    Write-Output 'Reset erlang in session'
}

Export-ModuleMember -Function Show-Erlang, Show-ErlangReleases
Export-ModuleMember -Function Set-Erlang, Reset-Erlang