# PRE2DUP package-parameter browser (GitHub Pages)

This repository publishes a static, client-side site for browsing PRE2DUP-derived antipsychotic package parameters.

## Regenerate exported data

From the repository root:

```bash
Rscript scripts/export_data.R
```

This reads `data/package_parameters_from_pre2dup.rds` (or `package_parameters_from_pre2dup.rds` at root) and writes:

- `docs/data/meds.json`
- `docs/data/meds.csv`

## Preview locally

Run any static server from the repository root, for example:

```bash
python3 -m http.server 8000
```

Then open:

- `http://localhost:8000/docs/`

## Enable GitHub Pages from `/docs`

1. Go to **Settings → Pages** in GitHub.
2. Under **Build and deployment**, set:
   - **Source:** `Deploy from a branch`
   - **Branch:** your publishing branch (for example `main`)
   - **Folder:** `/docs`
3. Save and wait for deployment.
