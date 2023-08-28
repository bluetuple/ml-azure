# configure azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.70"

    }


    # azuread provider for group management required
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.40"
    }

  }



}

provider "azuread" {
  tenant_id = data.azurerm_client_config.current.tenant_id
}

# for some cumbersome reason you need at least one feature statement in a provider
provider "azurerm" {
  features {
    api_management {
      # soft_deletion is depriciated in some modules e.g. cognitive serive, so it has to be generelly set on azurerm provider
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = false
    }
  }
}
