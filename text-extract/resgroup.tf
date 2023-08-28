# resourcegroup for cognitive services
resource "azurerm_resource_group" "rgcognitive" {
  name     = var.cognitive_resgroup
  location = var.default_location
  tags = {
    "class"     = "machine learning"
    "stage"     = "development"
    "ml_domain" = "text extraction"
  }
}
