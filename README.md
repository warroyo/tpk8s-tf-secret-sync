# TPK8s Secret Syncing with Terraform

This repo is a very simple example of using github actions and terraform to automate the syncing of secrets from an azure key vault into a Tanzu Platform for K8s Space. This works by taking looping over all secrets in an azure key vault that is provided through a variable and then connecting to the Tanzu Platform with the `kubectl` terraform provider and generating k8s secrets in the space for each of the AKV entries.

This could be easily adapted to handle multiple spaces,etc.

All of the code that makes this work lives in the `sync-secrets.yml` github workflow and the `main.tf`