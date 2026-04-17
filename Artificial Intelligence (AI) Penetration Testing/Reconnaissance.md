# Reconnaissance

## Ports and Protocols table

| Component                                                                 | Default Port(s)      | Protocol(s)                | Recon Endpoints                                                                            |
|---------------------------------------------------------------------------|----------------------|----------------------------|--------------------------------------------------------------------------------------------|
| **NVIDIA Triton** _(Loads models into memory and serves predictions at scale)_ | 8000, 8001, 8002     | HTTP, gRPC, Prometheus     | `/v2/health/ready`, `/v2/models`                                                           |
| **TensorFlow Serving** _(Google's model serving framework for TensorFlow models)_ | 8500, 8501           | gRPC, HTTP                 | `/v1/models/<name>`                                                                        |
| **TorchServe** _(PyTorch's official model serving framework)_             | 8080, 8081, 8082     | HTTP                       | `/ping`, `/models`                                                                         |
| **Ollama** _(Local runtime for running LLMs on your own hardware)_        | 11434                | HTTP                       | `/api/tags`, `/api/show`                                                                   |
| **vLLM** _(High-throughput LLM serving engine with OpenAI-compatible API)_ | 8000                 | HTTP                       | `/v1/models`                                                                               |
| **MLflow** _(Tracks experiments, stores models, and manages the ML lifecycle)_ | 5000                 | HTTP                       | `/api/2.0/mlflow/experiments/search`                                                       |
| **Kubeflow** _(Kubernetes-native platform for orchestrating ML pipelines)_ | 80, 443               | HTTP                       | `/pipeline/apis/v1beta1/pipelines`                                                         |
| **Ray** _(Distributed compute framework for scaling AI workloads)_        | 8265, 8000            | HTTP                       | `/api/jobs/`, Ray Dashboard                                                                |
| **Qdrant** _(Vector database for semantic search and RAG pipelines)_      | 6333, 6334            | HTTP, gRPC                 | `/collections`                                                                             |
| **Weaviate** _(Vector database with built-in GraphQL and module system)_  | 8080                 | HTTP, GraphQL              | `/v1/schema`, `/v1/meta`                                                                   |
| **Milvus** _(Distributed vector database for large-scale embedding storage)_ | 19530                | gRPC                       | Port 19530 connection                                                                      |
| **Jupyter Notebook** _(Interactive coding environment used by data scientists)_ | 8888                 | HTTP                       | `/api/kernels`, `/api/contents`                                                            |
| **MinIO** _(S3-compatible object storage often used for model artifacts)_ | 9000, 9001            | HTTP (S3-compatible)       | Bucket listing                                                                             |
| **Prometheus metrics** _(Exposed by Triton on 8002, TorchServe on 8082, etc.)_ | 8002, 8082            | HTTP                       | `/metrics`                                                                                 |

### 1) Scan AI Services

    sudo nmap -p 5000,6333,6334,8000,8001,8002,8888,9000,9001 -sV 10.10.45.0/24

### 2) Identify AI components

    sudo nmap -p 22,80,443,5432 -sV 10.10.45.0/24

Then compare with your first scan to check which hosts are running AI infrastructure or traditional infrastructure.
