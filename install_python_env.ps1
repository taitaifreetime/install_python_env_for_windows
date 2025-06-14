param
(
    [string]$version
)

Import-Module ".\components\install_python.ps1"
Import-Module ".\components\install_modules.ps1"

$majorMinor = $version.Substring(0, $version.LastIndexOf(".")).Replace(".", "")
$installPath = "$env:LOCALAPPDATA\Programs\Python\Python$majorMinor"


# check python path, python version, and then install python
Write-Output "### STEP1: Install Python ###"
$python_exists = Test-Path "$installPath\python.exe"
if ($python_exists) 
{
    Write-Output "$installPath\python.exe found."
    $pythonVersionOutput = & "$installPath\python.exe" --version
    $pythonVersionOutput = $pythonVersionOutput.Trim()
    $python_ver_match = "$pythonVersionOutput" -eq "Python $version"
    if ($python_ver_match) {
        Write-Output "Python $version is already installed."
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("Python $version is already installed.", 'Information', 'OK', 'Information')
    }
    else
    {
        Write-Output "Installed $pythonVersionOutput != $version."
        $code = Install-Python -version "$version"
        Add-Type -AssemblyName System.Windows.Forms
        if ($code -eq $true) {[System.Windows.Forms.MessageBox]::Show("Python $version Installation Successful.", 'Result', 'OK', 'Information')}
        else                 {[System.Windows.Forms.MessageBox]::Show("Python $version Installation Failed with exit code $code.", 'Error', 'OK', 'Error')}
    }
}
else
{
    Write-Output "$installPath\python.exe not found."
    $code = Install-Python -version "$version"
    Add-Type -AssemblyName System.Windows.Forms
    if ($code -eq $true) {[System.Windows.Forms.MessageBox]::Show("Python $version Installation Successful.", 'Result', 'OK', 'Information')}
    else                 {[System.Windows.Forms.MessageBox]::Show("Python $version Installation Failed with exit code $code.", 'Error', 'OK', 'Error')}
}


# check python path, python version, and then install python modules
Write-Output "### STEP2: Install Python Modules ###"
$python_exists = Test-Path "$installPath\python.exe"
if ($python_exists) 
{
    Write-Output "$installPath\python.exe found."
    $pythonVersionOutput = & "$installPath\python.exe" --version
    $pythonVersionOutput = $pythonVersionOutput.Trim()
    $python_ver_match = "$pythonVersionOutput" -eq "Python $version"
    if ($python_ver_match)
    {
        Write-Output "Installed $pythonVersionOutput == $version."
        $code = Install-Python-Modules -version "$version"
        Add-Type -AssemblyName System.Windows.Forms
        if ($code -eq $true) {[System.Windows.Forms.MessageBox]::Show("Python Modules Installation Successful.", 'Result', 'OK', 'Information')}
        else                 {[System.Windows.Forms.MessageBox]::Show("Python Modules Installation Failed with exit code $code.", 'Error', 'OK', 'Error')}
    } 
    else
    {
        Write-Output "Installed $pythonVersionOutput != $version."
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("Installed $pythonVersionOutput != $version. Python Modules Installation Failed.", 'Error', 'OK', 'Error')
    }
}