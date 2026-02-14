function Failed_Log {

    param(
        [array]$nodes
    )

    $logDir = "$env:USERPROFILE\Desktop\Logs"
    $logPath = Join-Path $logDir "failedLogin.csv"

    if (!(Test-Path $logDir)) {
        New-Item -ItemType Directory -Path $logDir -Force | Out-Null
    }

    $start = (Get-Date).AddDays(-1)
    $end = Get-Date
    $logname = "Security"

    $filterHashtable = @{
        LogName = $logname
        Id = 4625
        StartDate = $start
        EndDate = $end
    }

    $results = foreach ($computer in $ComputerName) {
        try {
            Get-WinEvent -ComputerName $computer -FilterHashtable $filterHashtable -ErrorAction Stop
        }
        catch {
            Write-Warning "Failed to query $computer : $_"
        }
    }

    $results | Export-Csv -Path $logPath -NoTypeInformation
}