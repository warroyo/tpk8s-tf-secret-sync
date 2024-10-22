terraform {
  required_version = ">= 0.13"
  backend "azurerm" {
    resource_group_name  = "warroyo-terraform"  # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "warroyoterraform"                      # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "spacessecrets"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "warroyo-dev.terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.6.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.0"
    }
  }
}

provider "kubectl" {
  load_config_file       = true
}

provider "azurerm" {
  features {}
  subscription_id = var.az_subscription_id
}