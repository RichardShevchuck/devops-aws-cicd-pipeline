# AWS CI/CD Pipeline — ECS Fargate

FastAPI Python application with a GitHub Actions pipeline that tests code, builds a Docker image, pushes it to ECR, and deploys it to ECS Fargate. Infrastructure provisioned with Terraform.

## Pipeline

```
git push → GitHub Actions
                │
          ┌─────▼──────┐
          │    test     │  pytest
          └─────┬───────┘
                │
          ┌─────▼──────────┐
          │ build & push   │  Docker build → ECR (tag: commit SHA)
          └─────┬───────────┘
                │
          ┌─────▼──────────┐
          │    deploy      │  Render ECS task def → deploy → wait for stable
          └─────────────────┘
```

## Architecture

```
Internet
  │
  ▼
ALB (public)
  │
  ▼
ECS Fargate Service
  │ (pulls image from)
  ▼
ECR Repository
```

## Tech Stack

- **App:** Python 3.12, FastAPI, Uvicorn
- **Container:** Docker, AWS ECR
- **CI/CD:** GitHub Actions
- **Compute:** AWS ECS Fargate
- **Load Balancer:** AWS ALB
- **IaC:** Terraform

## Terraform Modules

```
terraform/modules/
├── vpc/    # VPC, public/private subnets, IGW, route tables
├── ecr/    # ECR repository with lifecycle policies
├── iam/    # ECS task execution role
├── alb/    # ALB, target group, HTTP listener
└── ecs/    # ECS cluster, task definition, Fargate service
```

## GitHub Actions Secrets Required

Set in **GitHub → Settings → Environments → `ci-cd`**:

| Secret | Description |
|--------|-------------|
| `AWS_ACCESS_KEY_ID` | IAM user access key |
| `AWS_SECRET_ACCESS_KEY` | IAM user secret key |

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/` | Root |
| GET | `/health` | Health check |
| GET | `/info` | App info |

## Deploy Infrastructure

```bash
cd terraform/
terraform init
terraform apply
```

## Key Concepts

- **Image tagged with commit SHA** — every deploy is traceable to an exact git commit
- **ECS task definition render** — `aws-actions/amazon-ecs-render-task-definition` updates the image field
- **Waits for stability** — pipeline blocks until ECS confirms all tasks are healthy before marking success
