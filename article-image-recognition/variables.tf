# Define subscription variables for Terraform configuration

# Variable for specifying the default location used for management assets
variable "default_location" {
  type        = string
  description = "Default location used for management assets (typically westeurope)"
}

# Variable for specifying the name of the resource group for cognitive services
variable "cognitive_resgroup" {
  type        = string
  description = "The resource group for all cognitive services"
}

# Variable for specifying the name for the Custom Vision service
variable "custom_vision_name" {
  type        = string
  description = "Name for the Custom Vision service"
}

# Variable for specifying the own external IP address
variable "own_ip_address" {
  type        = string
  description = "Own external IP address"
}

# Variable for specifying the name of the generic cognitive service
variable "cognitive_service_name" {
  type        = string
  description = "Name of the generic cognitive service"
}

# Variable for specifying the name of the custom domain for the generic cognitive service
variable "cognitive_service_domain_name" {
  type        = string
  description = "Name of the custom domain for the generic cognitive service"
}
