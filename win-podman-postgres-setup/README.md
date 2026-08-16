# Windows Podman PostgreSQL Setup

This directory contains the Windows PowerShell scripts for creating a
repeatable local PostgreSQL development database. On first initialization,
PostgreSQL runs `init-db/init.sql`, creates `my_schema.my_table`, and inserts a
`Sample Data` record.

## Prerequisites

- Windows with PowerShell
- `winget`
- Python with `pip`
- WSL configured for the Podman machine

## 1. Clone the repository

```powershell
git clone https://github.com/BroGrammer89/postgres-db-automation.git
Set-Location postgres-db-automation\win-podman-postgres-setup
```

## 2. Install and initialize Podman

```powershell
.\install_podman_compose.ps1
```

The script installs Podman and `podman-compose` when required, then initializes
the Podman machine. Depending on the Windows and WSL setup, a new terminal or a
second run may be needed after installation so the newly installed commands are
available.

## 3. Create the database

```powershell
.\create_postgres_container.ps1
```

Enter the PostgreSQL username, password, and database name when prompted. The
current Windows script uses normal console input, so use it only in a trusted
local terminal. After startup, the script intentionally prints the supplied
password once as part of the local connection summary.

PostgreSQL is exposed at `localhost:5432`. The schema and sample record are
created automatically during the initial database setup.

## 4. Tear down the environment

```powershell
.\teardown_postgres_container.ps1
```

Teardown removes the project container and PostgreSQL image. It also runs
`podman volume prune -f` to provide a clean reset. This removes every unused
Podman volume, including unused volumes belonging to other projects, so review
your local Podman environment before running it.

## Credential handling

Credentials are supplied at runtime and are not written to this repository or
to a local `.env` file by these scripts. They are passed through the current
process environment to Podman Compose and remain available in the local
container configuration for that container's lifetime. Treat the final
connection summary as sensitive terminal output.
