resource "random_id" "random-id-4" {
  byte_length = 2
}

locals {
  region-map = {
    centralus = "CUS",
    eastus    = "EUS",
    westus    = "WUS",
    northcentralus = "NCUS",
    southcentralus = "SCUS",
    eastus2 = "EUS2",
    westus2 = "WUS2",
    westcentralus = "WCUS",
    canadacentral = "CCAN",
    canadaeast = "ECAN",
    brazilsouth = "BSOU",
    northeurope = "NEUR",
    westeurope = "WEUR",
  }

  base-name = "${substr(var.name, 0, 3)}-${substr(var.environment, 0, 3)}-${local.region-map[var.location]}-${random_id.random-id-4.hex}"
   
  # To append the environment name, region name, and random ID - suffix is added in the resources
  # define a map of environment names to their shortened versions
  environment-map = {
    development = "dev",
    production = "prod",
    test = "test",
    staging = "stg",
  }
  
  # convert the location to lowercase and use it to look up the region code
  lowercase-region = lower(local.region-map[var.location])
  
  # append the region code and random ID so that it can be used as a suffix across all resources
  resource-name-suffix = "${local.lowercase-region}-${local.environment-map[var.environment]}-${random_id.random-id-4.hex}" # Use the shortened environment name - appends the region name and random ID
}


