# Traefik Reverse proxy for Local Development Environment with Docker

This repository contains a basic setup for a local development environment using Docker. It is intended to be used as a starting point for setting up a local development environment for PHP projects using Docker. Other languages and frameworks can be added as needed.

This Setup allows for hosting multiple projects on a single machine, each with its own PHP and Apache containers. It also includes shared services like MySQL, PostgreSQL and Traefik for reverse proxy. Current setup provides two PHP versions (7.4 and 8.1) with appropriate Xdebug and Apache 2.4. Check Dockerfiles for more details.

## Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Git](https://git-scm.com/)
- [WSL2 (Windows Subsystem for Linux 2)](https://docs.microsoft.com/en-us/windows/wsl/install-win10) (Recommended for Windows users)
- [Docker Desktop](https://www.docker.com/products/docker-desktop) (Windows and Mac users)

## Getting Started

1. Clone this repository to your local machine:

   ```bash
   git clone
   ```

2. Update the `docker-compose.yml` and `Dockerfile` files in the `projects` and `shared-services` directories with your project-specific settings.
3. Copy the information in `hosts.md` file from the `global-configs` directory to your local machine's hosts file. See the `global-configs/hosts.md` file for more information.
4. Start the traefik service:

   ```bash
   cd ../traefik
   docker-compose up -d
   ```

5. Depending on your needs, start the shared services for your project:

   ```bash
   cd ../shared-services/mysql
   docker-compose up -d
   cd ../shared-services/postgres
   docker-compose up -d
   ```

6. Start the PHP and Apache containers for your project:

   ```bash
   cd projects/project1
   docker-compose up -d
   ```

7. Access your project in a web browser using the domain you specified in the `docker-compose.yml` file (e.g., `http://project1.localhost`).
8. Access databases using phpMyAdmin at `http://databases.localhost`.
9. Access postgres databases using pgAdmin at `http://pgadmin.localhost`.

## Further Customization

- If needed, add .ssh related files into the `global-configs/.ssh` directory and enable mounting in the `docker-compose.yml` file per project.
- By default `global-configs/.bashrc` file is mounted to the container. You can add your custom bash commands to this file.
- If needed, delete or update the .gitconfig file in the `global-configs` directory.

## Directory Structure

```plaintext
/home/your-username/
└── dev-environment/         # Top-level directory for all development work
    ├── projects/            # Directory for all project-specific files
    │   ├── project1/       # First project ()
    │   │   ├── .devcontainer/ # vscode settings
    │   │   ├── src/         # project files (from Git or live server)
    │   |   ├── testsrc/     # Test project files (for testing upped containers)
    │   │   ├── docker-compose.yml
    │   │   ├── php.ini
    │   │   ├── apache.conf
    │   │   ├── Dockerfile   # Custom Dockerfile for PHP container
    │   │
    │   ├── project2/ # Second project
    │   │   ├── .devcontainer/ # vscode settings
    │   │   ├── src/         # project files (from Git or live server)
    │   |   ├── testsrc/     # Test project files (for testing upped containers)
    │   │   ├── docker-compose.yml
    │   │   ├── php.ini
    │   │   ├── apache.conf
    │   │   ├── Dockerfile   # Custom Dockerfile for PHP container
    │   │
    │
    ├── shared-services/     # Shared services like MySQL and Traefik
    │   ├── mysql/           # Shared MySQL container with phpMyAdmin
    │   │   ├── docker-compose.yml
    │   │   └── data/        # Persistent MySQL data directory
    |   ├── postgres/           # Shared MySQL container with phpMyAdmin
    │   │   ├── docker-compose.yml
    │   │   └── data/        # Persistent Postgres data directory
    │   ├── traefik/         # Traefik for reverse proxy
    │   │   ├── docker-compose.yml
    │   │   ├── traefik.yml  # Traefik configuration file
    │   │   └── acme.json    # For storing Let's Encrypt certificates (if needed)
    │
    └── global-configs/      # Global configuration files (optional)
        ├── .bashrc          # Custom bash commands
        ├── .ssh/            # SSH keys and configuration
        ├── .gitconfig       # Git configuration
        ├── hosts.md         # Hosts file example for local development
        └── README.md        # Documentation for your development setup
```
