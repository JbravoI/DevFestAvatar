# DevFestAvatar — Historical Multi-Site Hosting Guide

This guide explains the architecture and step-by-step instructions to publish all past DevFest Avatar editions alongside the current 2026 application using **Firebase Multi-Site Hosting**.

---

## 1. Domain Architecture & Naming

On Google Firebase Hosting (`.web.app`):
- **Site IDs** are required by Google to follow DNS label standards: only lowercase letters, numbers, and hyphens (`-`) are permitted. Periods (`.`) are prohibited.
- Wildcard SSL certificates for `*.web.app` only support a single subdomain level.
- Therefore, on `.web.app`, the subdomains are named `https://devfestavatar-<year>.web.app`.

### URL Mapping

| Year | Target | Public Directory | Firebase Site ID | Production URL (.web.app) |
| :---: | :---: | :---: | :---: | :--- |
| **2026** | `2026` | `public` | `devfestavatar` | `https://devfestavatar.web.app` |
| **2025** | `2025` | `archive/2025` | `devfestavatar-2025` | `https://devfestavatar-2025.web.app` |
| **2024** | `2024` | `archive/2024` | `devfestavatar-2024` | `https://devfestavatar-2024.web.app` |
| **2022** | `2022` | `archive/2022` | `devfestavatar-2022` | `https://devfestavatar-2022.web.app` |
| **2021** | `2021` | `archive/2021` | `devfestavatar-2021` | `https://devfestavatar-2021.web.app` |
| **2020** | `2020` | `archive/2020` | `devfestavatar-2020` | `https://devfestavatar-2020.web.app` |
| **2019** | `2019` | `archive/2019` | `devfestavatar-2019` | `https://devfestavatar-2019.web.app` |

*(Note: If you connect a custom domain such as `devfestavatar.com`, you can configure DNS subdomains like `2025.devfestavatar.com` in Firebase Console and map each one to its respective hosting site.)*

---

## 2. Historical Git State

The static code for each historical edition has been extracted directly from the repository's commit history into `archive/<year>/`:

- **2025**: Commit [`1463603`](https://github.com/olorunfemidavis/DevFestAvatar/commit/1463603) (Final 2025 release)
- **2024**: Commit [`24365f0`](https://github.com/olorunfemidavis/DevFestAvatar/commit/24365f0) (2024 edition)
- **2022**: Commit [`8c40574`](https://github.com/olorunfemidavis/DevFestAvatar/commit/8c40574) (2022 template edition)
- **2021**: Commit [`fedfedc`](https://github.com/olorunfemidavis/DevFestAvatar/commit/fedfedc) (2021 edition)
- **2020**: Commit [`d216164`](https://github.com/olorunfemidavis/DevFestAvatar/commit/d216164) (2020 final update)
- **2019**: Commit [`bf798d1`](https://github.com/olorunfemidavis/DevFestAvatar/commit/bf798d1) (First 2019 edition)

All past editions run 100% in-browser using HTML5 Canvas client-side with no backend functions required.

---

## 3. Configuration Files

### `.firebaserc`
Binds each target name to its site ID in the `devfestavatar` Firebase project:
```json
{
  "projects": {
    "default": "devfestavatar"
  },
  "targets": {
    "devfestavatar": {
      "hosting": {
        "2026": ["devfestavatar"],
        "2025": ["devfestavatar-2025"],
        "2024": ["devfestavatar-2024"],
        "2022": ["devfestavatar-2022"],
        "2021": ["devfestavatar-2021"],
        "2020": ["devfestavatar-2020"],
        "2019": ["devfestavatar-2019"]
      }
    }
  }
}
```

### `firebase.json`
Defines each hosting target and its public source directory:
```json
{
  "hosting": [
    { "target": "2026", "public": "public" },
    { "target": "2025", "public": "archive/2025" },
    { "target": "2024", "public": "archive/2024" },
    { "target": "2022", "public": "archive/2022" },
    { "target": "2021", "public": "archive/2021" },
    { "target": "2020", "public": "archive/2020" },
    { "target": "2019", "public": "archive/2019" }
  ]
}
```

---

## 4. How to Deploy (When Ready)

### Step 1: Create the Sites in Firebase
Run the setup script once to provision the site IDs in Firebase:

*(Or on Linux / macOS: `./scripts/create-historical-sites.sh`)*

### Step 2: Deploy Historical Sites
Deploy a single year:

# or directly via Firebase CLI:
firebase deploy --only hosting:2025
```

Deploy all historical archives:

# or directly via Firebase CLI:
firebase deploy --only hosting:2025,hosting:2024,hosting:2022,hosting:2021,hosting:2020,hosting:2019
```

Deploy the current 2026 application:
```bash
firebase deploy --only hosting:2026
```
