# platform-services

Deployable services for the self-hosted platform. Governed by [platform-compliance](https://github.com/ashuangiras/platform-compliance) at profile `PROF-SERVICE-V1`. Infrastructure dependencies are managed by [platform-infrastructure](https://github.com/ashuangiras/platform-infrastructure).

## Service catalogue

| Service | Component | Health endpoint | Status |
|---|---|---|---|
| [Prometheus](service-contracts/prometheus.yaml) | `observability/` | `/-/healthy` | active |
| [Grafana](service-contracts/grafana.yaml) | `observability/` | `/api/health` | active |

## Directory structure

```
platform-services/
  main.tf                      ← orchestration (one module call per component group)
  variables.tf                 ← inputs
  outputs.tf                   ← health endpoints, URLs
  versions.tf                  ← S3 backend (MinIO) + docker provider
  │
  observability/               ← Prometheus + Grafana
    main.tf                    ← calls platform-modules observability modules
    variables.tf
    outputs.tf
    versions.tf
    config/
      prometheus.yml.example   ← copy to /srv/platform/prometheus/config/prometheus.yml
  │
  service-contracts/           ← CAT-001: service catalog entries
    prometheus.yaml
    grafana.yaml
```

## Deploy

```bash
# Create host directories
sudo mkdir -p /srv/platform/prometheus/{data,config} /srv/platform/grafana/data
sudo chown -R 65534:65534 /srv/platform/prometheus/data
sudo chown -R 472:472     /srv/platform/grafana/data

# Copy Prometheus config
cp observability/config/prometheus.yml.example /srv/platform/prometheus/config/prometheus.yml

# Configure state backend
cp backend.hcl.example backend.hcl  # fill in MinIO credentials

# Deploy
terraform init -backend-config=backend.hcl
terraform plan -out=tfplan
terraform apply tfplan
```

## Prerequisites

- **platform-infrastructure** must be running (Docker network `platform-backend`, Vault, Consul, MinIO)
- Docker installed on the target host
- Terraform ≥ 1.9
