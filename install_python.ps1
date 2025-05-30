param (
    [string]$version = "3.13.3"
)

$baseUrl = "https://www.python.org/ftp/python/$version"
$exeName = "python-$version-amd64.exe"
$output = "$env:TEMP\$exeName"

Write-Output "Downloading Python $version installer..."
Invoke-WebRequest -Uri "$baseUrl/$exeName" -OutFile $output
Write-Output "Download complete"

Write-Output "Installing Python $version..."
$majorMinor = $version.Substring(0, $version.LastIndexOf(".")).Replace(".", "")
$installPath = "$env:LOCALAPPDATA\Programs\Python\Python$majorMinor" # User\username\AppData\Local\
Start-Process -FilePath $output -ArgumentList "/quiet InstallAllUsers=0 PrependPath=0 Include_test=0 TargetDir=`"$installPath`"" -Wait # 1 for alluser, 0 for current user
Write-Output "Installation complete"

$currentUserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentUserPath -notlike "*$installPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentUserPath;$installPath", "User")
    [Environment]::SetEnvironmentVariable("Path", "$currentUserPath;$installPath;$installPath\Scripts", "User")
    Write-Output "PATH updated for current user"
} else {
    Write-Output "PATH already includes $installPath"
}

Write-Host "Python $version installed at $installPath."
Write-Host "You may need to reboot to enable tha path."

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("Python $version Installation Successful.", 'Result', 'OK', 'Information')
