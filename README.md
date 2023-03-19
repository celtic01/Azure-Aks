This repository aims to reflect my changes and improvements that I want to add to the original project(https://github.com/thomast1906/DevOps-The-Hard-Way-Azure).

1. Create a resource group, a storage account and a storage blob to store remote terraform state.
```./create-terraform-storage.sh```
2. Create an azure AD group for aks admins and add current logged in user as a member.
```./create-azure-ad-group.sh```