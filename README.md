# DevOps Project 06 — AWS CI/CD Pipeline

FastAPI app with automated CI/CD: GitHub Actions → Docker → ECR → ECS Fargate. Infrastructure as Code with Terraform.

## Architecture

```
Internet
    │
    ▼
┌─────────────────────────────────┐
│  VPC (10.0.0.0/16)              │
│                                 │
│  ┌──────────┬──────────┐        │
│  │ subnet 1 │ subnet 2 │        │
│  │ 10.0.1.0 │ 10.0.2.0 │◄─ IGW │
│  └────┬─────┴──────────┘        │
│       │                         │
│  ┌────▼────────────────┐        │
│  │  ALB (port 80)      │        │
│  └────┬────────────────┘        │
│       │                         │
│  ┌────▼────────────────┐        │
│  │  ECS Fargate        │        │
│  │  FastAPI (port 8000)│        │
│  └─────────────────────┘        │
└─────────────────────────────────┘
```

**CI/CD Pipeline:**
```
git push main
    │
    ▼
GitHub Actions
    ├── test          (pip install + pytest)
    ├── build-and-push (docker build → ECR)
    └── deploy        (update ECS task definition)
```

## Stack

| Tool | Purpose |
|------|---------|
| FastAPI | Python web framework |
| Docker | Containerization |
| GitHub Actions | CI/CD pipeline |
| AWS ECR | Docker image registry |
| AWS ECS Fargate | Container orchestration (serverless) |
| AWS ALB | Application Load Balancer |
| Terraform | Infrastructure as Code |

## Terraform Modules

```
terraform/modules/
├── vpc/    # VPC, subnets, IGW, route tables
├── ecr/    # ECR repository
├── iam/    # ECS task execution role
├── alb/    # ALB, target group, listener
└── ecs/    # ECS cluster, task definition, service
```

## API Endpoints

| Method | Path | Response |
|--------|------|----------|
| GET | `/` | `{"status": "ok", "service": "devops-api"}` |
| GET | `/health` | `{"status": "healthy"}` |
| GET | `/info` | `{"devops_project_number": "6"}` |

## Quick Start

**Prerequisites:** AWS credentials, Terraform, Docker

```bash
# 1. Deploy infrastructure
cd terraform/
terraform init
terraform apply

# 2. Add GitHub Secrets (Settings → Secrets → Actions → Environment: ci-cd)
#    AWS_ACCESS_KEY_ID
#    AWS_SECRET_ACCESS_KEY

# 3. Push to main — pipeline runs automatically
git push origin main
```

## Local Development

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload
# http://localhost:8000
```

## Cost

ALB ~$0.02/hour. Run `terraform destroy` when not in use.
