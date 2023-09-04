# Configure the Azure provider and required providers

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.70" # Define a compatible version of the AzureRM provider
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.40" # Define a compatible version of the AzureAD provider
    }
  }
}

# Configure the AzureAD provider for managing Azure Active Directory resources
provider "azuread" {
  tenant_id = data.azurerm_client_config.current.tenant_id # Set the tenant ID from Azure client configuration
}

# Define the AzureRM provider configuration with a feature statement

# Provider block for the AzureRM provider
provider "azurerm" {
  # Features configuration block
  features {
    api_management {
      # Set soft_deletion behavior for resources like cognitive services
      # Some modules, like cognitive service, deprecate soft_deletion, so it's configured here
      purge_soft_delete_on_destroy = true  # Purge soft-deleted resources on destroy
      recover_soft_deleted         = false # Do not recover soft-deleted resources
    }
  }
}
