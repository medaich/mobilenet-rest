# Use a smaller base image
FROM tensorflow/serving:2.13.0-gpu

# Copy your model to the container
COPY models/ /models/

# Set environment variables for memory optimization
ENV MODEL_NAME=mobilenet_ssd
ENV MODEL_BASE_PATH=/models
ENV TF_CPP_MIN_LOG_LEVEL=2
ENV MALLOC_ARENA_MAX=2

# Expose the port
EXPOSE 8501

# Start TensorFlow Serving with memory optimizations
CMD ["sh", "-c", "tensorflow_model_server \
    --bind=0.0.0.0 \
    --rest_api_port=${PORT:-8501} \
    --model_name=${MODEL_NAME} \
    --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} \
    --rest_api_timeout_in_ms=60000 \
    --max_num_load_retries=0 \
    --file_system_poll_wait_seconds=0 \
    --flush_filesystem_caches=false \
    --tensorflow_session_parallelism=1 \
    --tensorflow_intra_op_parallelism=1 \
    --tensorflow_inter_op_parallelism=1 \
    --enable_batching=false"]
