# GCP Microservices Platform

Ce projet déploie une boutique en ligne microservices sur GCP avec une infrastructure DevOps complète.


🧠 Objectif général
Tu vas déployer une application microservices sur Google Cloud Platform (GCP), avec :

Infrastructure créée via Terraform

Cluster GKE (Google Kubernetes Engine)

Services Kubernetes (YAML + Kustomize)

CI/CD avec Cloud Build

Monitoring avec Prometheus/Grafana

🛠️ Étape 0 — Prérequis sur ton environnement local
Assure-toi d'avoir installé :

Outil	Commande de vérification
Terraform	terraform version
Google SDK (gcloud)	gcloud version
kubectl	kubectl version --client
Docker (facultatif mais utile)	docker version
Un compte GCP avec un projet actif	gcloud projects list

📦 Étape 1 — Décompresser le projet
bash
Copy
Edit
unzip gcp-microservices-platform.zip
cd gcp-microservices-platform
☁️ Étape 2 — Authentification et config GCP
1. Connecte-toi à ton compte :
bash
Copy
Edit
gcloud auth login
2. Configure le projet (remplace your-project-id) :
bash
Copy
Edit
gcloud config set project your-project-id
3. Active les APIs nécessaires :
bash
Copy
Edit
gcloud services enable container.googleapis.com \
    compute.googleapis.com \
    cloudbuild.googleapis.com \
    monitoring.googleapis.com \
    logging.googleapis.com \
    artifactregistry.googleapis.com
🌐 Étape 3 — Déployer l'infrastructure avec Terraform
1. Aller dans l’environnement de production :
bash
Copy
Edit
cd terraform/environments/prod
2. Initialiser Terraform :
bash
Copy
Edit
terraform init
3. Lancer un plan pour voir ce qui sera créé :
bash
Copy
Edit
terraform plan
4. Appliquer l’infrastructure (confirme avec yes) :
bash
Copy
Edit
terraform apply
👉 Cela va créer :

Un réseau VPC

Un cluster Kubernetes privé (GKE)

Un sous-réseau pour pods et services

Un node pool avec nœuds Spot pour économiser

🚀 Étape 4 — Déployer l'application sur GKE
1. Récupérer les identifiants du cluster :
bash
Copy
Edit
gcloud container clusters get-credentials boutique-cluster --region us-central1
2. Appliquer les manifests K8s (base) :
bash
Copy
Edit
kubectl apply -k k8s-manifests/overlays/prod
🔄 Étape 5 — CI/CD avec Cloud Build
Si tu veux tester le pipeline CI/CD :

Active Cloud Build dans GCP Console

Connecte ton repo GitHub contenant ce projet

Déclenche un commit pour voir Cloud Build builder l’image et déployer

Sinon, tu peux manuellement build/push comme dans cloudbuild.yaml.

📊 Étape 6 — Monitoring avec Grafana/Prometheus
1. Installer Prometheus et Grafana (si pas déjà fait) :
Tu peux utiliser un Helm chart ou kube-prometheus-stack.

Ou tu peux ajouter un monitoring-stack.yaml que je peux te générer.

2. Importer le dashboard monitoring/dashboards/microservices.json dans Grafana
🧪 Étape 7 — Tester l’app
Expose le service frontend via un LoadBalancer ou port-forward :

bash
Copy
Edit
kubectl port-forward service/frontend 8080:80
Puis va sur http://localhost:8080

🧹 Étape 8 — Nettoyer (optionnel)
bash
Copy
Edit
cd terraform/environments/prod
terraform destroy
❓ Tu veux aller plus loin ?
Ajouter ELK (Elasticsearch + Kibana) pour logs

Intégrer Splunk (dans une version gratuite limitée)

Mettre Argo CD à la place de kubectl apply

Ajouter Sentry, Istio, ou des tests de résilience