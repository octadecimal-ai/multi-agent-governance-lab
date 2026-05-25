# Security Policy

This repository is a sanitized public portfolio extract. It must not contain credentials, customer data, private hostnames, private IP addresses, personal transcripts, production runbooks or secret material.

## Reporting

If you find sensitive data in this repository, open a private security advisory or contact the repository owner directly.

## Publication checklist

Before pushing public changes:

1. Scan working tree for credentials and private infrastructure identifiers.
2. Scan full Git history, not only the latest tree.
3. Confirm examples use placeholder domains, users and tokens.
4. Confirm no transcripts or generated logs are included.
5. Confirm audit examples are synthetic.
6. Confirm executable scripts do not perform destructive actions by default.

## Secret handling pattern

- Store secrets in a dedicated secret manager or OS keychain.
- Resolve secrets in a short-lived wrapper outside model context.
- Pass only scoped, task-specific handles to tools.
- Log the fact that a secret was resolved, never the value.
- Rotate credentials after suspicious use, failed isolation or accidental disclosure.

