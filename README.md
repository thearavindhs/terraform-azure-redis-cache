# Azure Redis Cache Terraform Module

This module provisions an Azure Redis Cache along with associated firewall rules, a Log Analytics Workspace, and Diagnostic Settings.

# Features

Unique Suffix: Generates a unique suffix for resource naming to ensure uniqueness across Azure.
Resource Group: Provisions a new Azure Resource Group specifically for the Redis Cache.
Redis Cache: Provisions an Azure Redis Cache with configurable SKU, family, and capacity. Supports patch schedules.
Firewall Rules: Dynamically creates firewall rules for the Redis Cache based on provided inputs.
Log Analytics Workspace: Sets up a workspace for log analytics related to the Redis Cache.
Diagnostic Settings: Creates diagnostic settings for auditing purposes on the Redis Cache.
Usage

```
module "redis_cache" {
  source = "<path-to-this-module>"

  environment          = "dev"
  default_location     = "East US"
  default_tags         = { "project" = "my-project" }
  redis_cache_name     = "my-redis-cache"
  sku_name             = "Basic"
  family               = "C"
  capacity             = 1
  minimum_tls_version  = "1.2"
  redis_version        = "6"
  patch_schedules      = [...]
  firewall_rules       = [...]
}
```

# Input Variables

environment: The environment name (e.g., dev, prod).
default_location: Default Azure location for resources.
default_tags: Default tags to attach to all provisioned resources.
redis_cache_name: Name of the Redis Cache.
sku_name: The SKU name for the Redis Cache.
family: The family for the Redis Cache (e.g., C).
capacity: The capacity level for the Redis Cache.
minimum_tls_version: Minimum TLS version supported by Redis Cache.
redis_version: Version of Redis to be used.
patch_schedules: A list of patch schedules for the Redis Cache.
firewall_rules: A list of firewall rules to apply to the Redis Cache.

# Outputs

Note: You might want to define and document outputs based on the resources you are creating, such as IDs or other attributes.