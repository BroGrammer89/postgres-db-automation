# Podman PostgreSQL Setup

This project provides scripts to set up a PostgreSQL database using Podman and Podman Compose. It includes scripts for installing Podman, creating a PostgreSQL container, and tearing down the container. The goal of this project is to standardize development databases across the team, making it easier to onboard new team members and reduce costs by avoiding the need for cloud databases and licenses.

## Purpose

- **Standardized Development Environment**: Ensures that all team members have a consistent database setup.
- **Ease of Onboarding**: New team members can quickly get started without needing to know container or Podman/Docker commands.
- **Cost Reduction**: Avoids the need for cloud databases and licenses by using local containerized databases.
- **Predefined Schema and Tables**: Provides a predefined schema and tables to ensure consistency across development environments.

## Directory Structure

```
win-podman-postgres-setup/
│
├── README.md
├
docker-compose.yaml
├── init-db/
│   └── init.sql
├── scripts/
│   ├── install_podman.ps1
│   ├── create_postgres_container.ps1
│   └── teardown_postgres_container.ps1
```

## Usage

### 1. Clone the Repository

Clone the repository to your local machine:

```sh
git clone https://github.com/BroGrammer89/win-podman-postgres-setup.git
cd win-podman-postgres-setup
```

### 2. Run the Installation Script

Run the installation script to install Podman and Podman Compose:

```powershell
.\scripts\install_podman_compose.ps1
```
Once the install has run sucessfully  you will see the need to run the install script a second time to initialise the Podman VM with the WSL version installed on your system
### 3. Create the PostgreSQL Container

Run the script to create the PostgreSQL container and initialize the database:

```powershell
.\scripts\create_postgres_container.ps1
```

You will be prompted to enter the PostgreSQL user, password, and database name.

### 4. Tear Down the PostgreSQL Container

When you are done, you can tear down the PostgreSQL container using the teardown script:

```powershell
.\scripts\teardown_postgres_container.ps1
```

## License

This project is licensed under the MIT License.
```

### Summary

This `README.md` file provides clear instructions for users on how to use the repository, as well as an explanation of the project's purpose and benefits. It includes sections on the directory structure, usage instructions, and the project's license. This should help users understand the project and get started quickly.
### Summary

This `README.md` file provides clear instructions for users on how to use the repository, as well as an explanation of the project's purpose and benefits. It includes sections on the directory structure, usage instructions, and the project's license. This should help users understand the project and get started quickly.