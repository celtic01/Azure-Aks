This repository aims to reflect my changes and improvements that I want to add to the original project(https://github.com/thomast1906/DevOps-The-Hard-Way-Azure).

1. Create a resource group, a storage account and a storage blob to store remote terraform state.
```./create-terraform-storage.sh```
2. Create an azure AD group for aks admins and add current logged in user as a member.
```./create-azure-ad-group.sh```
3. Create a resource group for ACR and ACR using terraform.
``` cd terraform-workspace/ACR ```
``` terraform init ```
``` terraform plan ```
``` terraform apply ```
4. Create a VNET and 2 subnets
``` cd terraform-workspace/VNET ```
``` terraform init ```
``` terraform plan ```
``` terraform apply ```
5. Create a Log Analytics workspace and solution
``` cd terraform-workspace/Log-Analytics ```
``` terraform init ```
``` terraform plan ```
``` terraform apply ```