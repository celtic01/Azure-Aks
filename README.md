This repository aims to reflect my changes and improvements that I want to add to the original project(https://github.com/thomast1906/DevOps-The-Hard-Way-Azure).

1. Create a resource group, a storage account and a storage blob to store remote terraform state.
```
./infrastructure/scripts/create-terraform-storage.sh
```
2. Create an azure AD group for aks admins and add current logged in user as a member.
```
./infrastructure/scripts/create-azure-ad-group.sh
```
3. Create a resource group for ACR and ACR using terraform.
```
cd infrastructure/terraform-workspace/ACR

terraform init

terraform plan

terraform apply
```
4. Create a VNET and 2 subnets
```
cd infrastructure/terraform-workspace/VNET

terraform init

terraform plan

terraform apply
```
5. Create a Log Analytics workspace and solution
```
cd infrastructure/terraform-workspace/Log-Analytics

terraform init

terraform plan

terraform apply
```
5. Create AKS cluster and assign roles to kubelet (acr-pull and scale-up;scale-down)
```
cd infrastructure/terraform-workspace/AKS

terraform init

terraform plan

terraform apply
```
6. Dockerize uber app and push to ACR as a starting point
```
docker build -t uberapp .

docker tag uberapp {name-of-acr}.azurecr.io/uberapp:v1

az acr login --name {name-of-acr}

docker push {name-of-acr}.azurecr.io/uberapp:v1
```
7. Install ARGOCD and apply CRD for ARGOCD to manage uber-app
```
az aks get-credentials --resource-group infrastructure-rg --name infrastructureaks

kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
7.1 ARGOCD needs to be exposed, for this example I modified the service from a ClusterIP to a LoadBalancer
```
kubectl edit svc argocd-server -n argocd
```
Get password of ARGOCD
```
{bash}
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo (get pw)

{powershell}
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String((kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}")))
```
Apply helm template of a CRD argo app from my other repo, which points to the helm template of uber-app (separate repo)
```
kubectl apply -f https://github.com/celtic01/argocd-uberapp/blob/main/helm/templates/uber-app.yaml
```
8. Uber app is stored in a separate repository, I have created the CI in github actions for it in order to push the image to ACR and update the app helm template which was in the same repo
```
https://github.com/celtic01/uber-app-clone/blob/main/.github/workflows/build-push.yml
```


