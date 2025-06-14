function Install-Python-Modules
{
    param 
    (
        [string]$version = "3.13.3"
    )

    # install modules
    $majorMinor = $version.Substring(0, $version.LastIndexOf(".")).Replace(".", "")
    $installPath = "$env:LOCALAPPDATA\Programs\Python\Python$majorMinor"
    $parentPath = Split-Path -Path $PSScriptRoot -Parent
    try
    {
        Write-Host "Installing Python modules..."
        if (Test-Path "$parentPath\requirements.txt") 
        {
            & "$installPath\python" -m pip install -r "$parentPath\requirements.txt"
        } 
        else 
        {
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.MessageBox]::Show("$parentPath\requirements.txt not found. Use default requirements.txt.", 'Error', 'OK', 'Error')
            & "$installPath\python" -m pip install -r "$parentPath\components\requirements_test.txt"
        }
        Write-Host "Python modules are installed."
    }
    catch
    {
        Write-Host "Failed with code $LASTEXITCODE"
        return $LASTEXITCODE
    }
    
    return $true
}