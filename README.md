# Flutter FastAPI Docker

This project is a full-stack application with a FastAPI backend and a Flutter frontend, containerized using Docker.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## TechStack
- Flutter: For frontend UI
- FastAPI: For backend rest api
- NGINX: To serve the Frontend
- PostgreSQL: as a SQL database


### Prerequisites

Before you begin, ensure you have the following installed:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Installation and Running

1. **Clone the Repository**

    ```bash
    git clone https://github.com/AlankritNayak/Flutter_FastAPI_Posgresql_Docker.git
    cd Flutter_FastAPI_Posgresql_Docker
    ```

2. **Build and Run with Docker Compose**

    In the root directory of the project, where the `docker-compose.yml` file is located, run:

    ```bash
    docker-compose up --build
    ```

    This command will build and start all the services defined in `docker-compose.yml`.

3. **Accessing the Application**

    - **Backend (FastAPI)**: The backend API will be accessible at `http://localhost:8008`.
    - **Frontend (Flutter Web App)**: The frontend application will be accessible at `http://localhost:8080`.
    - **Swagger Docs**: `http://localhost:8008/docs`
