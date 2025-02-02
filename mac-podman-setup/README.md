# Podman PostgreSQL Setup

This project provides scripts to set up a PostgreSQL database using Podman and Podman Compose. It includes scripts for installing Podman, creating a PostgreSQL container, and tearing down the container. The goal of this project is to standardize development databases across the team, making it easier to onboard new team members and reduce costs by avoiding the need for cloud databases and licenses.

## Purpose

- **Standardized Development Environment**: Ensures that all team members have a consistent database setup.
- **Ease of Onboarding**: New team members can quickly get started without needing to know container or Podman/Docker commands.
- **Cost Reduction**: Avoids the need for cloud databases and licenses by using local containerized databases.
- **Predefined Schema and Tables**: Provides a predefined schema and tables to ensure consistency across development environments.

## Directory Structure

```
mac-postgres-setup/
│
├── README.md
├── docker-compose.yaml
├── init-db/
│   └── init.sql
├── ── install_podman.sh
│   ── create_postgres_container.sh
│   ── teardown_postgres_container.sh
```

## Usage

### 1. Clone the Repository

Clone the repository to your local machine:

```sh
git clone https://github.com/BroGrammer89/mac-postgres-setup.git
cd mac-postgres-setup
```

### 2. Run the Installation Script

#### For Windows:

Run the installation script to install Podman and Podman Compose:

```bash
.install_podman_compose.ps1
```

#### For macOS:

Run the installation script to install Podman and Podman Compose:

```sh
./.install_podman.sh
```

### 3. Create the PostgreSQL Container

#### For Windows:

Run the script to create the PostgreSQL container and initialize the database:

```bash
.create_postgres_container.ps1
```

#### For macOS:

Run the script to create the PostgreSQL container and initialize the database:

```sh
./.create_postgres_container.sh
```

You will be prompted to enter the PostgreSQL user, password, and database name.

### 4. Tear Down the PostgreSQL Container

#### For Windows:

When you are done, you can tear down the PostgreSQL container using the teardown script:

```bash
.teardown_postgres_container.ps1
```

#### For macOS:

When you are done, you can tear down the PostgreSQL container using the teardown script:

```sh
./.teardown_postgres_container.sh
```

## License

This project is licensed under the MIT License.