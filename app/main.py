from fastapi import FastAPI


app = FastAPI()

@app.get("/health")
def hello():
    return {"status" : "healthy"}


@app.get("/info")
def info():
    return {"devops_project_number" : "6"}

@app.get("/")
def root():
    return {"status": "ok", "service": "devops-api"}


@app.get("/info")
def info():
    return {"CI_CD": "Implemented with GitHub Actions", "AWS_Services": ["ECR", "ECS", "VPC"]}
