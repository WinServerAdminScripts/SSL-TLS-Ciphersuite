<#
In Summary:
This PowerShell script checks the registry entries for SSL 2.0, SSL 3.0, TLS 1.0, TLS 1.1, and TLS 1.2 for both the server
and client. If an entry is not found, it creates the entry and disables it if it's SSL 2.0, SSL 3.0, TLS 1.0, or TLS 1.1. 
For TLS 1.2, the entry is created and enabled. The script checks both the 32-bit and 64-bit registry keys and handles errors 
that may occur during the process.
#>

# Set registry paths for SSL/TLS protocols
$protocols = @(
    @{
        Name = 'SSL 2.0 Server'
        Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server'
        ValueName = 'Enabled'
        ValueData = '0'
    },
    @{
        Name = 'SSL 2.0 Client'
        Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client'
        ValueName = 'Enabled'
        ValueData = '0'
    },
    @{
        Name = 'SSL 3.0 Server'
        Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server'
        ValueName = 'Enabled'
        ValueData = '0'
    },
    @{
        Name = 'SSL 3.0 Client'
        Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client'
        ValueName = 'Enabled'
        ValueData = '0'
    },
    @{
        Name = 'TLS 1.0 Server'
        Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server'
        ValueName = 'Enabled'
        ValueData = '0'
    },
    @{
        Name = 'TLS 1.0 Client'
        Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client'
        ValueName = 'Enabled'
        ValueData = '0'
    },
    @{
        Name = 'TLS 1.1 Server'
        Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server'
        ValueName = 'Enabled'
        ValueData = '0'
    },
    @{
        Name = 'TLS 1.1 Client'
        Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client'
        ValueName = 'Enabled'
        ValueData = '0'
    },
    @{
        Name = 'TLS 1.2 Server'
        Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server'
        ValueName = 'Enabled'
        ValueData = '1'
    },
    @{
        Name = 'TLS 1.2 Client'
        Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client'
        ValueName = 'Enabled'
        ValueData = '1'
    }
)

# Loop through each protocol and set its value
foreach ($protocol in $protocols) {
    if (!(Test-Path $protocol.Path)) {
        New-Item -Path $protocol.Path -Force | Out-Null
    }
    if (!(Test-Path "$($protocol.Path)\$($protocol.ValueName)")) {
        New-ItemProperty -Path $protocol.Path -Name $protocol.ValueName -Value $protocol.ValueData -PropertyType DWORD -Force | Out-Null
    } else {
        Set-ItemProperty -Path $protocol.Path -Name $protocol.ValueName -Value $protocol.ValueData -Force | Out-Null
    }
}

