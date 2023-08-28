# managing of cognitive services


resource "azurerm_cognitive_account" "cognitive_service" {
  name                = var.cognitive_service_name
  location            = var.default_location
  resource_group_name = var.cognitive_resgroup
  kind                = "CognitiveServices"
  sku_name            = "S0"

  # customdomain name
  custom_subdomain_name = var.cognitive_service_domain_name

  network_acls {
    default_action = "Deny"

    ip_rules = [var.own_ip_address]
  }



  depends_on = [azurerm_resource_group.rgcognitive]

  timeouts {
    delete = "5m"
  }

  tags = {
    "class"     = "machine learning"
    "stage"     = "development"
    "ml_domain" = "text extraction"
  }
}

