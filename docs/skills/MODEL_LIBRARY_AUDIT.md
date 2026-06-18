# Model Library Audit

**Purpose:** Audit the external model library for duplicates and compliance.

## Procedure

1. List all model files in the external library directory
2. Compare against `registry/MODEL_REGISTRY.md`
3. Flag any model files not in the registry
4. Flag any entries in the registry with no corresponding file
5. Identify duplicate files (same name, same size, same hash)

## Duplicate Detection

Compare by:
- File name
- File size
- SHA256 hash (for exact match confirmation)

## Report

Generate a report with:
- Total model files found
- Registry entries matched
- Unregistered models
- Missing models (in registry but not on disk)
- Duplicates identified
