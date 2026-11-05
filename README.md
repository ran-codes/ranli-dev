# Personal Site

## Maintenance

### Development `quarto preview`

- This is a Quarto (v1.8.22 CLI) static site 
- builds into `_sites/` folder as per the `_quarto.yml` 
- Usually during development, we can use `quarto preview` to see changes live and iterate
- works on `_development` branch to reduce number of GitHub Actions builds (default branch is `main`)

### Production `./scripts/deploy.bat`

- Context
    - The end product is a GitHub pages site
    - The page is deployed by GitHub Actions using contents in the `docs/` folder
- Deployment logic is bundled in shell script `scripts/deploy.bat` for convenience
    - It builds the site into `_site/` folder with quarto render
    - Deletes existing `docs/` folder or creates if not exists
    - Copies `_site/` folder to `docs/` folder
- Pushing to branch and then merging main will trigger GitHub actions to deploy the site

## Folders

### Posts

This is the blog posts folder. Each post is a separate `.qmd` file. The folder naming convention is `YYYY-MM-DD-title.qmd`.


### Resume

This is currently dated to 2025-09-18 version. Note we edit resumes in https://www.junian.dev/markdown-resume/.

### Profile Picture

Currently using  `RL_Head_cropped.jpg`