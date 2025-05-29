FROM tensorflow/serving:latest

# Copy your model to the container
COPY models/ /models/

# Expose ports for gRPC and REST API
EXPOSE 8500 8501

# Set environment variables
ENV MODEL_NAME=mobilenet_ssd
ENV MODEL_BASE_PATH=/models

# Start TensorFlow Serving
CMD ["sh", "-c", "tensorflow_model_server --port=8500 --rest_api_port=8501 --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME}"]