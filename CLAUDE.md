# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

**Run app locally:**
```bash
source .venv/bin/activate
uvicorn app.main:app --reload
```

**Build & run Docker container:**
```bash
docker build -t devops-api .
docker run -p 8000:8000 devops-api
```

**Install dependencies:**
```bash
pip install -r requirements.txt
```

**Terraform (from `terraform/` directory):**
```bash
terraform init
terraform plan
terraform apply
```

## Architecture

Single-file FastAPI app (`app/main.py`) served by uvicorn on port 8000. Three endpoints: `GET /` (health check), `GET /health`, `GET /info`.

Containerized via `Dockerfile` using `python:3.12-slim`. The local venv uses Python 3.14 but the container targets 3.12.

Terraform module structure under `terraform/modules/` targets AWS with five modules: `vpc`, `ecs`, `alb`, `ecr`, `iam`. Root `terraform/main.tf`, `variables.tf`, and `outputs.tf` and all module files are currently empty scaffolds — this IaC is not yet implemented.
