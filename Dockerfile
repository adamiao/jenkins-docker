# Start from the python:3.8-slim image
FROM python:3.8-slim

# Copy the current project to the folder '/my-application' within the container
COPY . /my-application

# Set the work directory
WORKDIR /my-application

# Install the Python packages necessary for the project to run
RUN pip install --no-cache-dir -r requirements.txt

# Run the tests
RUN ["python", "-m", "pytest", "-v", "calculator/", "--junitxml=result.xml"]

CMD tail -f /dev/null