# macOS Podman PostgreSQL Setup

This directory contains the macOS scripts for creating a repeatable local
PostgreSQL development database. On first initialization, PostgreSQL runs
`init-db/init.sql`, creates `my_schema.my_table`, and inserts a `Sample Data`
record.

## Prerequisites

- macOS
- Homebrew
- Python 3 with `pip3`

## 1. Clone the repository

```sh
git clone https://github.com/BroGrammer89/postgres-db-automation.git
cd postgres-db-automation/mac-podman-setup
```

## 2. Install and initialize Podman

```sh
bash install_podman.sh
```

The script installs Podman and `podman-compose` when required, then initializes
the Podman machine.

## 3. Create the database

```sh
bash create_postgres_container.sh
```

Enter the PostgreSQL username, password, and database name when prompted. The
password is masked during entry. After startup, the script intentionally prints
the supplied password once as part of the local connection summary.

PostgreSQL is exposed at `localhost:5432`. The schema and sample record are
created automatically during the initial database setup.

## 4. Tear down the environment

```sh
bash teardown_postgres_container.sh
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
