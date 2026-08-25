#!/usr/bin/env pwsh

Write-Host "Exporting VS Code extensions..."
code --list-extensions | Out-File -Encoding utf8 "$PSScriptRoot\data.txt"
Write-Host "Done"
