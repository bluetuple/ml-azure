# output entdpoint and primary key
data "azurerm_cognitive_account" "csa" {
  name                = var.cognitive_service_name
  resource_group_name = var.cognitive_resgroup
  # importat without dependancy terraform plan will thor an error as the resouce does
  # not exist when run the very first time
  depends_on = [ azurerm_cognitive_account.cognitive_service ]  
}

output "endpoint" {
  value     = data.azurerm_cognitive_account.csa.endpoint
  sensitive = true
}
output "primary-key" {
  value     = data.azurerm_cognitive_account.csa.primary_access_key
  sensitive = true
}

resource "local_file" "env" {
  filename = ".env"
  content  = "COG_SERVICE_ENDPOINT=${data.azurerm_cognitive_account.csa.endpoint}\nCOG_SERVICE_KEY=${data.azurerm_cognitive_account.csa.primary_access_key}"


}
