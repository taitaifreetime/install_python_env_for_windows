Set-Location -Path $PSScriptRoot
$parentPath = Split-Path -Path $PSScriptRoot -Parent

if (Test-Path "$parentPath\requirements.txt") {
    python -m pip install -r $parentPath\requirements.txt
    $code = $LASTEXITCODE
    Add-Type -AssemblyName System.Windows.Forms
    if ($code -eq 0) {
        [System.Windows.Forms.MessageBox]::Show('Module Installation Successful', 'Result', 'OK', 'Information')
    } else {
        [System.Windows.Forms.MessageBox]::Show("Module Installation Failed with exit code $code", 'Error', 'OK', 'Error')
    }
} else {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show('requirements.txt not found', 'Error', 'OK', 'Error')
}
