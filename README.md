### Docker
Docker Build
```
docker build -t flask-app:latest
```

Docker container 
```
docker container run -d -p 5000:5000 flask-app:latest
```

---
### Terraform
**Configure AWS Credentials:** Ensure AWS credentials are set in ~/.aws/credentials or as environment variables.


**Initialize Terraform**
```
terraform init
```

**Format and Validate:**
```
terraform fmt
terraform validate
```

**Preview Changes:**
```
terraform plan
```

**Apply Configuration:**
```
terraform apply
```

**Destroy Infrastructure** (when needed):
```
terraform destroy
```

## k8s
```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```
Check: Pod working or not

```
kubectl get pods
kubectl get svc
```

##### Get LoadBalancer URL
```
kubectl get svc flask-service -o wide
```

### Troubleshooting
#### Check pod logs
```
kubectl logs -l app=flask
```
