# GCP Microservices Platform

This project deploys an online boutique microservices application on **Google Cloud Platform** with a complete DevOps infrastructure. 🚀

---

## 🧠 Project Goal

Deploy a microservices application on Google Cloud Platform (GCP) with:

* Infrastructure-as-Code using **Terraform**
* **GKE** (Google Kubernetes Engine) cluster
* Kubernetes services (YAML + Kustomize)
* CI/CD pipeline with **Cloud Build**
* Monitoring using **Prometheus/Grafana**

---

## 🛠️ Step 0 - Local Environment Prerequisites

Ensure you have these tools installed:

| Tool                | Verification Command       |
| ------------------- | -------------------------- |
| Terraform           | `terraform version`        |
| Google SDK (gcloud) | `gcloud version`           |
| kubectl             | `kubectl version --client` |
| Docker              | `docker version`           |

**GCP Account Requirements:**

* Active Google Cloud account
* GCP project with billing enabled
* Owner/Editor permissions on the project

---

## 📦 Step 1 - Extract Project Files

```bash
unzip gcp-microservices-platform.zip
cd gcp-microservices-platform
```

---

## ☁️ Step 2 - GCP Authentication & Configuration

Authenticate to your Google account:

```bash
gcloud auth login
```

Configure your GCP project (replace `your-project-id`):

```bash
gcloud config set project your-project-id
```

Enable required APIs:

```bash
gcloud services enable container.googleapis.com \
    compute.googleapis.com \
    cloudbuild.googleapis.com \
    monitoring.googleapis.com \
    logging.googleapis.com \
    artifactregistry.googleapis.com
```

---

## 🌐 Step 3 - Deploy Infrastructure with Terraform

Navigate to the production environment:

```bash
cd terraform/environments/prod
```

Initialize Terraform:

```bash
terraform init
```

Preview infrastructure changes:

```bash
terraform plan
```

Apply infrastructure (confirm with "yes"):

```bash
terraform apply
```

**This will create:**

* VPC network
* Private Kubernetes cluster (GKE)
* Pod and service subnets
* Spot node pool for cost savings
* Cloud SQL database instance
* GCS bucket for Terraform state

---

## 🚀 Step 4 - Deploy Application to GKE

Configure cluster credentials:

```bash
gcloud container clusters get-credentials boutique-cluster --region us-central1
```

Apply Kubernetes manifests:

```bash
kubectl apply -k ../k8s-manifests/overlays/prod
```

Verify deployment:

```bash
kubectl get pods -n boutique
```

---

## 🔄 Step 5 - CI/CD with Cloud Build

To set up the CI/CD pipeline:

* Connect your GitHub repository to Cloud Build
* Create a build trigger using the `cicd/cloudbuild.yaml` file
* Push changes to trigger automatic builds

Manual test (optional):

```bash
gcloud builds submit --config cicd/cloudbuild.yaml
```

---

## 📊 Step 6 - Monitoring with Grafana/Prometheus

Install monitoring stack:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack
```

Access Grafana:

```bash
kubectl port-forward svc/prometheus-grafana 3000:80
```

Visit [http://localhost:3000](http://localhost:3000)
Login: `admin` / Password: `prom-operator`

Import dashboard from `monitoring/dashboards/microservices.json`

---

## 🧪 Step 7 - Test the Application

Access the frontend:

```bash
kubectl port-forward service/frontend 8080:80
```

Visit [http://localhost:8080](http://localhost:8080)

OR expose via LoadBalancer:

```bash
kubectl expose deployment frontend --type=LoadBalancer --name=frontend-lb
kubectl get service frontend-lb
```

---

## 🧹 Step 8 - Clean Up Resources

To destroy all created resources:

```bash
cd terraform/environments/prod
terraform destroy
```

---

## 🚀 Going Further

**Log Management:**

* Add ELK stack (Elasticsearch + Logstash + Kibana)
* Integrate with Cloud Logging

**Service Mesh:**

```bash
istioctl install --set profile=demo -y
```

**Advanced CI/CD:**

* Implement Argo CD for GitOps deployments
* Add automated canary releases

**Resilience Testing:**

Integrate Chaos Mesh for failure injection:

```bash
kubectl apply -f https://mirrors.chaos-mesh.org/latest/install.sh
```

**Security Enhancements:**

* Enable Binary Authorization
* Add Cloud Armor WAF rules
* Implement VPC Service Controls

---

## 📚 Learning Resources

* GKE Best Practices
* Terraform GCP Modules
* Kubernetes Patterns

---

If you want, I can also help you generate a Markdown file with this content. Would you like that?
