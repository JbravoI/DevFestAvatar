# ==============================================================================
# DevFestAvatar - Create Historical Multi-Site Hosting Instances
# ==============================================================================
# This script creates secondary hosting sites in the 'devfestavatar' Firebase
# project and binds each target in .firebaserc.
#
# Resulting URLs on .web.app:
#   2026 (Default):  https://devfestavatar.web.app
#   2025:            https://devfestavatar-2025.web.app
#   2024:            https://devfestavatar-2024.web.app
#   2022:            https://devfestavatar-2022.web.app
#   2021:            https://devfestavatar-2021.web.app
#   2020:            https://devfestavatar-2020.web.app
#   2019:            https://devfestavatar-2019.web.app
#
# Custom Domain (Optional):
#   You can also bind subdomains (e.g., 2025.devfestavatar.com) to these sites
#   in the Firebase Console -> Hosting -> Add custom domain.
# ==============================================================================

$years = @("2025", "2024", "2022", "2021", "2020", "2019")

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  DevFestAvatar: Setting up Firebase Multi-Site Hosting" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Target apply for 2026 default site
Write-Host "`n[1/3] Binding 2026 target to default site 'devfestavatar'..." -ForegroundColor Yellow
firebase target:apply hosting 2026 devfestavatar

# 2. Create secondary sites and bind targets
Write-Host "`n[2/3] Creating historical hosting sites..." -ForegroundColor Yellow
foreach ($year in $years) {
    $siteId = "devfestavatar-$year"
    Write-Host "`n--> Creating site: $siteId" -ForegroundColor Green
    firebase hosting:sites:create $siteId

    Write-Host "--> Binding target '$year' to site '$siteId'" -ForegroundColor Green
    firebase target:apply hosting $year $siteId
}

Write-Host "`n[3/3] Configuration complete!" -ForegroundColor Cyan
Write-Host "Your .firebaserc and firebase.json are ready."
Write-Host "To deploy a specific year, run:"
Write-Host "  firebase deploy --only hosting:2025" -ForegroundColor Yellow
Write-Host "To deploy all historical sites, run:"
Write-Host "  .\scripts\deploy-historical.ps1 -All" -ForegroundColor Yellow
