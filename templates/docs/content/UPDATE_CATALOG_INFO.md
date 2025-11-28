# Instructions for updating catalog-info.yaml

## Check Your catalog-info.yaml

### If catalog-info.yaml does NOT exist in your repository:
✅ **Good news!** A new `catalog-info.yaml` file has been created for you with the TechDocs annotation already included. No action needed!

### If catalog-info.yaml ALREADY exists:
You need to check if it has the TechDocs annotation and add it if missing.

## Required Manual Step

Add the following line under `metadata.annotations` in your existing `catalog-info.yaml` ONLY if missing:

```yaml
metadata:
  annotations:
    backstage.io/techdocs-ref: dir:.
```

## Why is this manual?

Backstage scaffolder templates use `replace: false` to protect your existing files. This means:
- If you don't have a `catalog-info.yaml`, we create one with the annotation
- If you already have one, we don't modify it (to prevent accidental data loss)

## Example

### Before:
```yaml
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: my-component
  annotations:
    github.com/project-slug: cds-snc/my-repo
spec:
  type: service
  owner: my-team
```

### After:
```yaml
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: my-component
  annotations:
    github.com/project-slug: cds-snc/my-repo
    backstage.io/techdocs-ref: dir:.  # ← ADD THIS LINE
spec:
  type: service
  owner: my-team
```

## What this does

The `backstage.io/techdocs-ref: dir:.` annotation tells Backstage where to find your TechDocs configuration. The `dir:.` value means the documentation is in the same directory as the `catalog-info.yaml` file (the root of your repository).

The mkdocs.yml file in this PR specifies which directory contains your markdown files (either `docs/` or `documentation/`).

## Alternative Locations

If your documentation is in a subdirectory, you can specify:
- `dir:./docs` - Documentation is in a `docs/` subdirectory
- `dir:./documentation` - Documentation is in a `documentation/` subdirectory
- `url:https://...` - Documentation is hosted externally

For most cases, `dir:.` is the recommended approach.
