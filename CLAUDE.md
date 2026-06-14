# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

FastAPI app with a full CI/CD pipeline: GitHub Actions builds a Docker image, pushes to AWS ECR, and deploys to ECS Fargate. Infrastructure provisioned with Terraform.

## Architecture

```
Internet
    │
    ▼
ALB (port 80)
    │
    ▼
ECS Fargate (port 8000)
    │
    └── pulls image from ECR
```

**CI/CD flow:**
```
git push → GitHub Actions → docker build → ECR push → ECS deploy
```

## App

Single-file FastAPI app (`app/main.py`) on port 8000. Three endpoints:
- `GET /` — root
- `GET /health` — health check (used by ALB)
- `GET /info` — project info

## Run Locally

```bash
source .venv/bin/activate
uvicorn app.main:app --reload
```

## Docker

```bash
docker build -t devops-api .
docker run -p 8000:8000 devops-api
```

## Terraform

```bash
cd terraform/
terraform init
terraform plan
terraform apply
terraform destroy   # run when not in use to avoid costs
```

## Terraform Modules

| Module | Purpose |
|--------|---------|
| `vpc` | VPC, 2 public subnets, IGW, route tables |
| `ecr` | ECR repository for Docker images |
| `iam` | ECS task execution role |
| `alb` | ALB, target group, HTTP listener, ALB SG |
| `ecs` | ECS cluster, task definition, service, ECS SG |

## GitHub Actions

Workflow: `.github/workflows/deploy.yaml`  
Trigger: push to `main`  
Environment secrets: `ci-cd` (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)

Key env vars in workflow:
- `ECR_REPOSITORY: my-ecr-repo`
- `ECS_CLUSTER: ecs-cluster`
- `ECS_SERVICE: my-ecs-service`
- `CONTAINER_NAME: app`
- `TASK_DEFINITION: my-ecs-task`

## AWS Credentials

```bash
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_DEFAULT_REGION=us-east-1
```

## Cost Warning

ALB costs ~$0.02/hour. Run `terraform destroy` when not in use.
