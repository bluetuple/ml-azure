# Define a resource group for the Azure Cognitive Services

# Create a resource group to contain the Azure Cognitive Services resources
resource "azurerm_resource_group" "rgcognitive" {
  name     = var.cognitive_resgroup # Name of the resource group
  location = var.default_location   # Location where the resource group will be created

  # Assign tags to the resource group for better organization and management
  tags = {
    "class"     = "machine learning" # Tag indicating the class of resources within the group
    "stage"     = "development"      # Tag indicating the stage of development
    "ml_domain" = "text extraction"  # Tag specifying the domain of machine learning
  }
}
