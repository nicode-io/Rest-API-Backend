# Define OS/Python base image
FROM python:3.9-alpine3.13
# Define maintainer email/website
LABEL maintainer="nicode.io"

# Avoid Python buffering to, for example,  display console result instantly
ENV PYTHONUNBUFFERED 1

# Copy files
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
# Define working directory
WORKDIR /app
# Expose ports
EXPOSE 8000

ARG DEV=false
# Run command in one block to avoid creating
# multiple container layer (each line can be exectuted separately)
# 1st line create virtual environement
RUN python -m venv /py && \
    # Install or update PIP
    /py/bin/pip install --upgrade pip && \
    # Install requirements file to our project using pip
    /py/bin/pip install -r /tmp/requirements.txt && \
    # Install linting tool only in development mode
    if [ $DEV = "true" ]; \
      then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    # "fi" ends the condition statement
    fi && \
    # Remove tmp folder
    rm -rf /tmp && \
    # Add user inside our linux image  \
    # NEVER USE ROOT USER IN DOCKER CONTAINER
    adduser \
        --disabled-password \
        --no-create-home \
        django-user


# Define path to environment variables
ENV PATH="/py/bin:$PATH"

# Specify user to switch to
USER django-user