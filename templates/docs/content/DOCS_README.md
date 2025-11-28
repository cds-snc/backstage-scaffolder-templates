# Add TechDocs Template

This template adds TechDocs configuration to an existing repository.

## What it creates

- `mkdocs.yml` - MkDocs configuration file (with configurable docs_dir)
- `docs/index.md` or `documentation/index.md` - Initial documentation homepage
- `.github/workflows/backstage_techdocs.yml` - GitHub Actions workflow for publishing
- `.github/workflows/scripts/get_entity_info.sh` - Helper script for catalog entity extraction
- `UPDATE_CATALOG_INFO.md` - Instructions for updating catalog-info.yaml

## Handling Existing docs/ Directory

If your repository already has a `docs/` directory:

### Option 1: Keep Existing Structure
Choose `docs` as the directory name. The template will:
- **Preserve existing files** - Your current docs/ content won't be overwritten
- Add `index.md` only if it doesn't exist
- Add mkdocs.yml to configure TechDocs only if it does not exist
- Add GitHub workflow for publishing only if it does not exist

### Option 2: Use Separate Directory
Choose `documentation/` as the directory name. The template will:
- Create a new `documentation/` directory for TechDocs
- Keep your existing `docs/` untouched
- Configure mkdocs.yml to use `documentation/`

**Recommendation**: If you have existing documentation in `docs/`, review what's there first. You can either:
- Integrate TechDocs with existing content (Option 1)
- Keep them separate (Option 2)

The `replace: false` setting ensures no existing files are overwritten.

## Usage

1. Run this template from Backstage
2. Provide the repository URL and component name
3. Review the generated PR
4. Follow instructions in `UPDATE_CATALOG_INFO.md` to add the TechDocs annotation ONLY if needed. 
5. Merge the PR

## Manual Steps Required

After the PR is created, you'll need to:

1. **Review the PR changes**
2. **Merge the PR** to add TechDocs files to your repository
3. **Manually add the TechDocs annotation** to your `catalog-info.yaml` ONLY if it does not already exist:

```yaml
metadata:
  annotations:
    backstage.io/techdocs-ref: dir:.
```

4. **Commit and push** the catalog-info.yaml change
5. **Wait for the GitHub Action** to run and publish your docs

This manual step is required because Backstage scaffolder actions cannot currently parse and conditionally modify existing YAML files in a safe way.

## Customization

After the PR is merged, you can:

- Add more markdown files to the `docs/` directory
- Update the navigation in `mkdocs.yml`
- Customize the site name and description
- Add MkDocs plugins for additional features

## Learn More

- [Backstage TechDocs Documentation](https://backstage.io/docs/features/techdocs/)
- [MkDocs Documentation](https://www.mkdocs.org/)
- [MkDocs Material Theme](https://squidfunk.github.io/mkdocs-material/)
