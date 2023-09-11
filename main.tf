# create the unique suffix for to be used for all resources
resource "random_id" "unique_suffix" {
  byte_length = 4
}

# create the resource group
resource "azurerm_resource_group" "redis_cache_resource_group" {
  name     = "redis-cache-resource-group-${var.environment}-${random_id.unique_suffix.hex}"
  location = var.default_location
  tags     = var.default_tags
}

# create the redis cache
resource "azurerm_redis_cache" "redis_cache" {
  name                = var.redis_cache_name
  location            = azurerm_resource_group.redis_cache_resource_group.location
  resource_group_name = azurerm_resource_group.redis_cache_resource_group.name
  sku_name            = var.sku_name
  family              = var.family
  capacity            = var.capacity
  minimum_tls_version = var.minimum_tls_version
  redis_version       = var.redis_version
  tags = merge(var.default_tags, {
    "name"           = var.redis_cache_name
    "resource-group" = azurerm_resource_group.redis_cache_resource_group.name
  })

  dynamic "patch_schedule" {
    for_each = var.patch_schedules
    content {
      day_of_week    = patch_schedule.value.day_of_week
      start_hour_utc = patch_schedule.value.start_hour_utc
    }
  }
}

# create the redis cache firewall rule
resource "azurerm_redis_firewall_rule" "redis_cache_firewall_rule" {
  for_each = { for rule in var.firewall_rules : rule.name => rule }

  name                = "redis_firewall_${var.environment}_${each.key}_${random_id.unique_suffix.hex}"
  redis_cache_name    = azurerm_redis_cache.redis_cache.name
  resource_group_name = azurerm_resource_group.redis_cache_resource_group.name
  start_ip            = each.value.start_ip
  end_ip              = each.value.end_ip
}

# Create the Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "redis_cache_log_analytics" {
  # defaults to sku = "PerGB2018" and retention_in_days = 30
  name                = "redis-cache-log-analytics-${var.environment}-${random_id.unique_suffix.hex}"
  location            = azurerm_resource_group.redis_cache_resource_group.location
  resource_group_name = azurerm_resource_group.redis_cache_resource_group.name
  tags = merge(var.default_tags, {
    "name"           = "redis-cache-log-analytics-${var.environment}-${random_id.unique_suffix.hex}"
    "resource-group" = azurerm_resource_group.redis_cache_resource_group.name
  })
}

# Create the Diagnostic Setting for the Redis Cache
resource "azurerm_monitor_diagnostic_setting" "redis_cache_diagnostic" {
  name                       = "redis-cache-diagnostic-${var.environment}-${random_id.unique_suffix.hex}"
  target_resource_id         = azurerm_redis_cache.redis_cache.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.redis_cache_log_analytics.id

  enabled_log {
    category_group = "audit"
  }
}
