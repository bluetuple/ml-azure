# subscription variables (to be able to access resources from different subs)


variable "default_location" {
  type        = string
  description = "default location used for managemtn assets (mostly westeurope)"
}


variable "cognitive_resgroup" {
  type        = string
  description = "The resurcegroup for all cognitive services"
}

variable "custom_vision_name" {
  type        = string
  description = "Name for custom vision service"
}


# Own IP adress
variable "own_ip_address" {
  type        = string
  description = "own external ip address"
}

# variable for generic cognitive service
variable "cognitive_service_name" {
  type        = string
  description = "name of generic cognitive service"
}
variable "cognitive_service_domain_name" {
  type        = string
  description = "name of generic cognitive service custom domain"
}
