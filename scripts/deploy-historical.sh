#!/usr/bin/env bash
# ==============================================================================
# DevFestAvatar - Deploy Historical Hosting Targets
# ==============================================================================
# Usage:
#   ./scripts/deploy-historical.sh 2025
#   ./scripts/deploy-historical.sh all
# ==============================================================================

set -e

YEAR=$1

case "$YEAR" in
    2019|2020|2021|2022|2024|2025|2026)
        echo "Deploying target for year $YEAR..."
        firebase deploy --only "hosting:$YEAR"
        ;;
    all)
        echo "Deploying all historical archives..."
        firebase deploy --only "hosting:2025,hosting:2024,hosting:2022,hosting:2021,hosting:2020,hosting:2019"
        ;;
    *)
        echo "Usage: $0 [year|all]"
        echo "Available historical targets:"
        echo "  - 2025: firebase deploy --only hosting:2025"
        echo "  - 2024: firebase deploy --only hosting:2024"
        echo "  - 2022: firebase deploy --only hosting:2022"
        echo "  - 2021: firebase deploy --only hosting:2021"
        echo "  - 2020: firebase deploy --only hosting:2020"
        echo "  - 2019: firebase deploy --only hosting:2019"
        echo "  - all:  Deploy all 6 historical sites simultaneously"
        exit 1
        ;;
esac
