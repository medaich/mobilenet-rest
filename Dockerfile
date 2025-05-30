FROM tensorflow/serving:latest

# Copy your model to the container
COPY models/ /models/

# Set environment variables
ENV MODEL_NAME=mobilenet_ssd
ENV MODEL_BASE_PATH=/models

# Expose the port (Render will map this to their assigned port)
EXPOSE 8501

# Start TensorFlow Serving with proper host binding
# Use PORT environment variable if available, otherwise default to 8501
CMD ["sh", "-c", "tensorflow_model_server --bind=0.0.0.0 --rest_api_port=${PORT:-8501} --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME}"]
