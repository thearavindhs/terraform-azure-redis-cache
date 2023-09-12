module "data" {
    source = "./data"
    name = var.name
    location = var.location
    environment = var.environment
}