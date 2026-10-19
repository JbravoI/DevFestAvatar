# ==============================================================================
# DevFestAvatar - Deploy Historical Hosting Targets
# ==============================================================================
# Usage:
#   .\scripts\deploy-historical.ps1 -Year 2025
#   .\scripts\deploy-historical.ps1 -All
#   .\scripts\deploy-historical.ps1 -DryRun
# ==============================================================================

param (
    [string]$Year,
    [switch]$All,
    [switch]$DryRun
)

$validYears = @("2025", "2024", "2022", "2021", "2020", "2019")

if ($All) {
    $targets = ($validYears | ForEach-Object { "hosting:$_" }) -join ","
    Write-Host "Deploying all historical archives: $targets" -ForegroundColor Cyan
    if ($DryRun) {
        Write-Host "[DRY RUN] Would execute: firebase deploy --only $targets" -ForegroundColor Yellow
    } else {
        firebase deploy --only $targets
    }
}
elseif ($Year) {
    if ($validYears -contains $Year -or $Year -eq "2026") {
        Write-Host "Deploying target for year $Year..." -ForegroundColor Cyan
        if ($DryRun) {
            Write-Host "[DRY RUN] Would execute: firebase deploy --only hosting:$Year" -ForegroundColor Yellow
        } else {
            firebase deploy --only "hosting:$Year"
        }
    } else {
        Write-Error "Invalid year: '$Year'. Valid historical years are: $($validYears -join ', ')"
    }
}
else {
    Write-Host "DevFestAvatar Historical Deploy Helper" -ForegroundColor Cyan
    Write-Host "Available historical targets:"
    foreach ($y in $validYears) {
        Write-Host "  - Year $y -> https://devfestavatar-$y.web.app (Command: firebase deploy --only hosting:$y)"
    }
    Write-Host "`nTo deploy a single year:" -ForegroundColor Yellow
    Write-Host "  .\scripts\deploy-historical.ps1 -Year 2025" -ForegroundColor White
    Write-Host "To deploy all historical years:" -ForegroundColor Yellow
    Write-Host "  .\scripts\deploy-historical.ps1 -All" -ForegroundColor White
}
