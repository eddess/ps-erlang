<#
    .Synopsis
        Displays various Erlang related information

    .Description
        Displays various Erlang related information.
#>
function Show-Erlang {
    if ( -Not $erlang.active ) {
        Write-Output 'No active installation in this session'
        return
    }
}


function Show-ErlangReleases {
    Param (
        [ValidateSet('system', '32', '64', 'all')]
        [System.String]
        $arch = 'system'
    )

    Try {
        $ProgressPreference = 'silentlyContinue'
        $releases = (((Invoke-WebRequest -UseBasicParsing $erlang.download_uri).links).href) | where {$_ -like "*.exe"}
    }
    Finally {
        $ProgressPreference = 'Continue'
    }

    if ( -Not $releases ) {
        Throw 'No releases found. Check availability of ' + $erlang.download_uri
    }

    $check_arch = $null

    switch ($arch) {
        'system' {
            if ( [System.Environment]::Is64BitOperatingSystem ) {
                $check_arch = '64'
            }
            else {
                $check_arch = '32'
            }
        }
        
        '32' { $check_arch = '32' }

        '64' { $check_arch = '64' }
    }

    $releases | ForEach-Object  {
        if ( (-Not $check_arch) -or ($_ -like $erlang.download_prefix + $check_arch + "*") ) {
            Write-Output $_.substring(0, $_.length - 4).substring($erlang.download_prefix.length)
        }
    }
}


function Show-ErlangInstalls {
    (Get-ChildItem -Directory  $erlang.root) | 
    ForEach-Object {
        if( $_.Name -eq $erlang.active ) {
            Write-Output $_.Name '(active)'
        }
        else {
            Write-Output $_.Name
        }
    }
}

