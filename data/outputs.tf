output "region-map" {
    value = local.region-map
}

output "base-name" {
    value = local.base-name
}

output "lowercase-region" {
    value = local.lowercase-region
}

output "resource-name-suffix" {
    value = local.resource-name-suffix
}

output "random_id" {
    value = random_id.random-id-4.hex
}