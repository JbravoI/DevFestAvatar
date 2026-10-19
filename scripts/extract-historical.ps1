# ==============================================================================
# DevFestAvatar - Extract Historical Editions from Git History
# ==============================================================================
# This script extracts each historical edition's public directory from Git
# into the archive/ folder without switching branches or modifying working tree.
# ==============================================================================

$historicalCommits = [ordered]@{
    "2025" = "1463603"  # Final 2025 campaign release
    "2024" = "24365f0"  # Final 2024 campaign release
    "2022" = "8c40574"  # Final 2022 campaign release
    "2021" = "fedfedc"  # Final 2021 campaign release
    "2020" = "d216164"  # 2020 final update
    "2019" = "bf798d1"  # Initial 2019 release
}

Write-Host "Extracting historical editions into archive/ folder..." -ForegroundColor Cyan

foreach ($year in $historicalCommits.Keys) {
    $commit = $historicalCommits[$year]
    $destDir = "archive\$year"
    $tarPath = "archive\$year.tar"

    New-Item -ItemType Directory -Force -Path $destDir | Out-Null
    Write-Host "Extracting $year (commit $commit) -> $destDir" -ForegroundColor Green

    git archive --format=tar $commit public -o $tarPath
    tar -xf $tarPath -C $destDir --strip-components=1
    Remove-Item $tarPath -Force
}

Write-Host "All historical editions extracted successfully!" -ForegroundColor Cyan
