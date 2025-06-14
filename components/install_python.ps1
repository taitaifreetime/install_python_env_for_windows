function Install-Python
{
    param 
    (
        [string]$version = "3.13.3"
    )

    # install python
    $majorMinor = $version.Substring(0, $version.LastIndexOf(".")).Replace(".", "")
    $installPath = "$env:LOCALAPPDATA\Programs\Python\Python$majorMinor"
    $baseUrl = "https://www.python.org/ftp/python/$version"
    $exeName = "python-$version-amd64.exe"
    $output = "$env:TEMP\$exeName"
    try
    {
        Write-Host "Downloading Python $version installer..."
        Invoke-WebRequest -Uri "$baseUrl/$exeName" -OutFile $output
        Write-Host "Download complete"

        Write-Host "Installing Python $version..."
        Start-Process -FilePath $output -ArgumentList "/quiet InstallAllUsers=0 PrependPath=0 Include_test=0 TargetDir=`"$installPath`"" -Wait # 1 for alluser, 0 for current user
        Write-Host "Installation complete"

        $currentUserPath = [Environment]::GetEnvironmentVariable("Path", "User")
        if ($currentUserPath -notlike "*$installPath*") {
            [Environment]::SetEnvironmentVariable("Path", "$currentUserPath;$installPath", "User")
            [Environment]::SetEnvironmentVariable("Path", "$currentUserPath;$installPath;$installPath\Scripts", "User")
            Write-Host "PATH updated for current user"
        } else {
            Write-Host "PATH already includes $installPath"
        }

        Write-Host "Python $version installed at $installPath."
        Write-Host "You may need to reboot to enable tha path."
    }
    catch
    {
        Write-Host "Failed with code $LASTEXITCODE"
        return $LASTEXITCODE
    }

    return $true
}
