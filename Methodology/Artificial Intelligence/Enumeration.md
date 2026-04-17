# AI Enumeration

### 1) Passive Recon

Use Shodan, Censys and FOFA for AI Service banners

    port:5000 "MLflow",
    port:8888 title:"Home Page - Select or create a notebook",
    http.title:"Ray Dashboard"

Search GitHub for leaked credentials

    filename:.env MLFLOW_TRACKING_URI,
    filename:.env HF_TOKEN,
    filename:config.json model_name site:github.com

Check arXiv and engineering blogs for published model architectures.

Check DockerHub and GitHub Container Registry for organisation-named ML images. Public container images frequently contain hardcoded configurations. Look at job postings. A listing for an "MLflow Administrator" or "Kubeflow Platform Engineer" tells you exactly what is deployed.

### 2) Active Recon

Nmap scan

    sudo nmap -p 5000,6333,8000,8001,8002,8080,8265,8500,8501,8888,9000,11434,19530 -sV --script=http-title,http-headers <target>

#### How to utilize the scan report:

1) Pay attention to gRPC services on ports 8001 and 8500 that Nmap may report as generic.

2) Follow up with grpcurl for anything that looks like gRPC.

3) Check for Prometheus metrics endpoints (`/metrics`) on every discovered service.

4) These are often on separate ports (8002 for Triton, 8082 for TorchServe) and leak deployment topology.

### 3) API Fingerprinting

Run ffuf or feroxbuster with a wordlist containing these endpoints

    /v1/models
    /v2/models
    /v2/health/ready
    /api/2.0/mlflow/experiments/list
    /api/2.0/mlflow/registered-models/list
    /pipeline/apis/v1beta1/pipelines
    /api/serve/deployments/
    /v1/schema
    /v1/meta
    /api/kernels
    /api/contents
    /openapi.json
    /docs
    /graphql
    /metrics
    /api/tags
    /api/show
    /collections
    /healthz
    /ping

### 4) Metadata Extraction

On MLflow: Experiments, registered models, model versions (with artifact URIs and user IDs), training runs, and artifact listings. Five API calls that map the entire ML portfolio.

On Triton or TF Serving: Model config endpoints for tensor specs and framework identification.

On vector databases: Schema and collection endpoints for data type and embedding model identification.

On Jupyter: Kernel listings and notebook cell contents for cleartext credentials.

### 5) Supply Chain Review

Identify model download sources visible in configurations, notebook cells, and container build logs. Check whether internal model artifact buckets (S3, GCS, MinIO) are publicly readable. Audit requirements.txt and Pipfile contents for internal package names that could be squatted on PyPI. Check container registries for image pull access without credentials.
