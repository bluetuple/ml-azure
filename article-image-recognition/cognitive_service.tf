# Terraform script to manage Azure Cognitive Services

# Define a resource for creating an Azure Cognitive Services account
resource "azurerm_cognitive_account" "cognitive_service" {
  name                = var.cognitive_service_name # Name of the Cognitive Services account
  location            = var.default_location       # Location where the resource will be created
  resource_group_name = var.cognitive_resgroup     # Resource group where the account will be placed
  kind                = "CognitiveServices"        # Specify the kind of service as CognitiveServices
  sku_name            = "S0"                       # Specify the SKU for the service

  # Configure a custom domain name for the Cognitive Services account
  custom_subdomain_name = var.cognitive_service_domain_name

  # Configure network access control rules for the Cognitive Services account
  network_acls {
    default_action = "Deny" # Set the default action to deny traffic

    ip_rules = [var.own_ip_address] # Allow traffic only from the specified IP address
  }

  # Depend on the creation of the specified resource group
  depends_on = [azurerm_resource_group.rgcognitive]

  # Define timeouts for resource operations
  timeouts {
    delete = "5m" # Specify the timeout for resource deletion
  }

  # Assign tags to the resource for better organization and management
  tags = {
    "class"     = "machine learning" # Tag indicating the class of the resource
    "stage"     = "development"      # Tag indicating the stage of development
    "ml_domain" = "text extraction"  # Tag specifying the domain of machine learning
  }
}
