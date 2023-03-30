This repository aims to reflect my changes and improvements that I want to add to the original project(https://github.com/thomast1906/DevOps-The-Hard-Way-Azure).

1. Create a resource group, a storage account and a storage blob to store remote terraform state.
```./infrastructure/scripts/create-terraform-storage.sh```
2. Create an azure AD group for aks admins and add current logged in user as a member.
```./infrastructure/scripts/create-azure-ad-group.sh```
3. Create a resource group for ACR and ACR using terraform.
``` cd infrastructure/terraform-workspace/ACR ```
``` terraform init ```
``` terraform plan ```
``` terraform apply ```
4. Create a VNET and 2 subnets
``` cd infrastructure/terraform-workspace/VNET ```
``` terraform init ```
``` terraform plan ```
``` terraform apply ```
5. Create a Log Analytics workspace and solution
``` cd infrastructure/terraform-workspace/Log-Analytics ```
``` terraform init ```
``` terraform plan ```
``` terraform apply ```
5. Create AKS cluster and assign roles to kubelet (acr-pull and scale-up;scale-down)
``` cd infrastructure/terraform-workspace/AKS ```
``` terraform init ```
``` terraform plan ```
``` terraform apply ```
6. Dockerize uber app and push to ACR as a starting point
``` docker build -t uberapp . ```
``` docker tag uberapp {name-of-acr}.azurecr.io/uberapp:v1 ```
``` az login acr --{name-of-acr} ```
``` docker push {name-of-acr}.azurecr.io/uberapp:v1 ```
