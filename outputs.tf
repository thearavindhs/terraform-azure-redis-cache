output "primary_access_key" {
    value = azurerm_redis_cache.redis_cache.primary_access_key
    description = "The primary access key for the Redis Cache"
    sensitive = true
}

output "primary_connection_string" {
    value = azurerm_redis_cache.redis_cache.primary_connection_string
    description = "The primary connection string for the Redis Cache"
    sensitive = true
}

output "hostname" {
    value = azurerm_redis_cache.redis_cache.hostname
    description = "The hostname for the Redis Cache"
    sensitive = false
}

output "ssl_port" {
    value = azurerm_redis_cache.redis_cache.ssl_port
    description = "The SSL port for the Redis Cache"
    sensitive = false
}