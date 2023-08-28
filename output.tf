# output.tf

# This data block retrieves existing Azure Cognitive Service account details.
# It is important for use cases where you might not be creating the service within Terraform 
# but you still need to access its details for other operations.
data "azurerm_cognitive_account" "csa" {
  # Set the name and resource group of the cognitive service we want to retrieve details for.
  name                = var.cognitive_service_name
  resource_group_name = var.cognitive_resgroup
  
  # Ensure this data block depends on the creation of the actual cognitive service.
  # This ensures that the Terraform plan command does not throw an error when the resource 
  # does not exist initially. This is particularly important for the first run.
  depends_on = [ azurerm_cognitive_account.cognitive_service ]
}

# Output the endpoint of the Azure Cognitive Service for external consumption.
# Marking it as 'sensitive' ensures it does not get displayed directly in Terraform outputs.
output "endpoint" {
  value     = data.azurerm_cognitive_account.csa.endpoint
  sensitive = true
}

# Output the primary key of the Azure Cognitive Service for external consumption.
# Like the endpoint, it's marked 'sensitive' to avoid direct display in Terraform outputs.
output "primary-key" {
  value     = data.azurerm_cognitive_account.csa.primary_access_key
  sensitive = true
}

# This resource block is responsible for creating a local ".env" file.
# It saves key details like endpoint and primary access key of the Azure Cognitive Service.
# Useful for applications that need these details in environment variables.
resource "local_file" "env" {
  # Set the name of the file where details will be saved.
  filename = ".env"

  # Construct the content of the file using string interpolation.
  # The resultant file will have lines like:
  # COG_SERVICE_ENDPOINT=<endpoint_value>
  # COG_SERVICE_KEY=<primary_key_value>
  content  = "COG_SERVICE_ENDPOINT=${data.azurerm_cognitive_account.csa.endpoint}\nCOG_SERVICE_KEY=${data.azurerm_cognitive_account.csa.primary_access_key}"
}
