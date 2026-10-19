#!/usr/bin/env bash
# ==============================================================================
# DevFestAvatar - Create Historical Multi-Site Hosting Instances
# ==============================================================================
# Resulting URLs on .web.app:
#   2026 (Default):  https://devfestavatar.web.app
#   2025:            https://devfestavatar-2025.web.app
#   2024:            https://devfestavatar-2024.web.app
#   2022:            https://devfestavatar-2022.web.app
#   2021:            https://devfestavatar-2021.web.app
#   2020:            https://devfestavatar-2020.web.app
#   2019:            https://devfestavatar-2019.web.app
# ==============================================================================

set -e

echo "=== DevFestAvatar: Setting up Firebase Multi-Site Hosting ==="

# 1. Target apply for 2026 default site
echo "Binding 2026 target to default site 'devfestavatar'..."
firebase target:apply hosting 2026 devfestavatar

# 2. Create secondary sites and bind targets
years=("2025" "2024" "2022" "2021" "2020" "2019")

for year in "${years[@]}"; do
    site_id="devfestavatar-${year}"
    echo "Creating site: ${site_id}..."
    firebase hosting:sites:create "${site_id}" || true

    echo "Binding target '${year}' to '${site_id}'..."
    firebase target:apply hosting "${year}" "${site_id}"
done

echo "=== Configuration complete! ==="
echo "To deploy a specific year, run:"
echo "  firebase deploy --only hosting:2025"
