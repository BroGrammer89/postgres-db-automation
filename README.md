# PostgreSQL Development Database Automation

This repository creates a consistent local PostgreSQL development database on
Windows and macOS using Podman and Podman Compose. It was created to give
developers a repeatable environment without requiring the organisation to pay
for a cloud-hosted development database.

The main outcome is more than a running PostgreSQL container: every developer
starts with the same schema, table, and sample record. The SQL in `init-db` is
automatically applied when PostgreSQL is initialized, so the environment is
ready for development with predictable sample data.

## What the project automates

- Installs or verifies the local Podman tooling required by each platform.
- Initializes and starts a Podman machine.
- Creates a PostgreSQL container with user-supplied runtime configuration.
- Creates the `my_schema.my_table` sample table.
- Inserts a `Sample Data` record for a consistent starting state.
- Tears down the local container, image, and unused volumes when a clean reset
  is required.

## Repository structure

```text
postgres-db-automation/
├── mac-podman-setup/
│   ├── create_postgres_container.sh
│   ├── docker-compose.yaml
│   ├── init-db/init.sql
│   ├── install_podman.sh
│   └── teardown_postgres_container.sh
└── win-podman-postgres-setup/
    ├── create_postgres_container.ps1
    ├── docker-compose.yaml
    ├── init-db/init.sql
    ├── install_podman_compose.ps1
    └── teardown_postgres_container.ps1
```

## Getting started

```sh
git clone https://github.com/BroGrammer89/postgres-db-automation.git
cd postgres-db-automation
```

Continue with the instructions for your platform:

- [macOS setup](mac-podman-setup/README.md)
- [Windows setup](win-podman-postgres-setup/README.md)

## Runtime credential design

Database credentials are supplied interactively when the create script runs.
The scripts do not contain default passwords and do not write the supplied
values to this repository or to a local `.env` file. The password is passed to
Podman Compose through the current process environment and is available in the
local container configuration for the lifetime of that container.

After startup, the scripts intentionally print the supplied database password
once in the connection summary. This is designed for a local development
environment so that the developer can immediately connect to the database.
Terminal output should therefore be treated as sensitive and should not be
copied into tickets, logs, screenshots, or shared terminals.

The macOS prompt masks the password while it is entered. The current Windows
prompt uses normal console input.

## Clean-reset behaviour

The teardown scripts intentionally run `podman volume prune -f`. This removes
all unused Podman volumes, including unused volumes created by other projects.
The behaviour provides the clean, repeatable reset expected by this project,
but developers who share one Podman environment across projects should review
their unused volumes before running teardown.

## Intended use

This project is intended for local development and onboarding. It is not a
production database deployment or a replacement for production secret
management, backups, high availability, or managed database operations.
