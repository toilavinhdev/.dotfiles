#!/usr/bin/env pwsh

Write-Host "Installing VS Code extensions..."
Get-Content "$PSScriptRoot\data.txt" | ForEach-Object { code --install-extension $_ }
Write-Host "Done"
