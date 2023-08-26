# file for setting values to variables for dev environment
# auto.tfvars file to be used to set values for vaiables defined in a variables.tf 8or any other .tf file
# any variable definition in same scope defined by variable "xyz" {} can be initialized here


# Resource Group for cognitive serviced
cognitive_resgroup = "<resource-groupname>"

# Default location for development
default_location = "<region>"

# Own IP
own_ip_address = "<own-external-ip"



# cognitive service name (generic service)
cognitive_service_name        = "sbx_eu_cognitiveservice"
cognitive_service_domain_name = "sbx-cs"