# Use an official Python runtime as a base image
FROM python:3.10.0-slim-buster

# Copy the current directory contents into the container at /usr/src/app
# Adjust this if your app directory is nested in another directory
COPY ./app /app

WORKDIR /app

# Copy the requirements.txt file and install Python dependencies
COPY requirements.txt .

RUN apt-get update \
    && apt-get -y install libpq-dev gcc \
    && pip install psycopg2

RUN pip install -r requirements.txt

# Copy .env file
COPY .env .env

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Command to run the application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
