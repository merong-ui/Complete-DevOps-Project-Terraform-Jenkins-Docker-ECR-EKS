# Dockerfile for the Python application
FROM python:3.11-slim

WORKDIR /app

# Copy the application code and requirements file into the container
COPY app.py .
COPY requirements.txt .

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that the application will run on
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]