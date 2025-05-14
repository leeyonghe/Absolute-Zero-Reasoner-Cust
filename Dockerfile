FROM nvidia/cuda:12.4.1-cudnn8-devel-ubuntu22.04

# 기본 패키지 설치
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리 설정
WORKDIR /workspace

# Python 환경 설정
ENV PYTHONPATH=/workspace
ENV PATH="/workspace:${PATH}"

# 필요한 Python 패키지 설치
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# 추가 패키지 설치
RUN pip3 install --no-cache-dir \
    flash-attn --no-build-isolation \
    vllm==0.7.3 \
    transformers==4.47.1 \
    "math-verify[antlr4_9_3]" \
    debugpy

# Jupyter Notebook 설정
RUN pip3 install --no-cache-dir jupyter
EXPOSE 8888

# TensorBoard 설정
RUN pip3 install --no-cache-dir tensorboard
EXPOSE 6006

# 기본 명령어 설정
CMD ["/bin/bash"] 