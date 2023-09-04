# Retrieving and outputting Azure Cognitive Services endpoint and primary key

# Define a data source to retrieve information about the Azure Cognitive Services account
data "azurerm_cognitive_account" "csa" {
  name                = var.cognitive_service_name # Name of the Cognitive Services account
  resource_group_name = var.cognitive_resgroup     # Resource group where the account is located

  # Ensure proper sequencing during resource creation
  depends_on = [azurerm_cognitive_account.cognitive_service]
}

# Output the Cognitive Services endpoint
output "endpoint" {
  value     = data.azurerm_cognitive_account.csa.endpoint # Extract and expose the endpoint
  sensitive = true                                        # Mark this information as sensitive
}

# Output the primary access key for the Cognitive Services account
output "primary-key" {
  value     = data.azurerm_cognitive_account.csa.primary_access_key # Extract and expose the primary key
  sensitive = true                                                  # Mark this information as sensitive
}

# Create a local file to store environment variables
resource "local_file" "env" {
  filename = ".env" # Name of the local file to create
  # Populate the content of the file with Cognitive Services information
  content = "COG_SERVICE_ENDPOINT=${data.azurerm_cognitive_account.csa.endpoint}\nCOG_SERVICE_KEY=${data.azurerm_cognitive_account.csa.primary_access_key}"
}
