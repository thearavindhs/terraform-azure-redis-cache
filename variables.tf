variable "name" {
  description = "The name of the Redis cache"
  type        = string
  nullable    = false
}

variable "environment" {
  description = "Environment for resource naming"
  type        = string
  nullable    = false
}

variable "location" {
  description = "location for resources"
  type        = string
  # nullable    = false
  default     = "eastus"
}

variable "default_tags" {
  description = "Default tags to be added to resources"
  type        = map(string)
  default = {
    terraform = "true"
  }
}

variable "sku_name" {
  description = "The SKU name of the Redis cache"
  type        = string
  default     = "Basic"
}

variable "family" {
  description = "The SKU family of the Redis cache"
  type        = string
  default     = "C"
}

variable "capacity" {
  description = "The SKU capacity of the Redis cache"
  type        = number
  default     = 1
}

variable "minimum_tls_version" {
  description = "The minimum TLS version for the Redis cache"
  type        = string
  default     = "1.2"
}

variable "redis_version" {
  description = "The version of Redis to use"
  type        = string
  default     = "6"
}

variable "patch_schedules" {
  description = "The patch schedule for the Redis cache"
  type = list(object({
    day_of_week    = string
    start_hour_utc = number
  }))
  default = [
    {
      day_of_week    = "Saturday" # Friday 9 PM Eastern
      start_hour_utc = 1
    },
    {
      day_of_week    = "Sunday" # Saturday 9 PM Eastern
      start_hour_utc = 1
    }
  ]
}

variable "firewall_rules" {
  description = "List of firewall rules for the Redis Cache."
  type = list(object({
    name     = string
    start_ip = string
    end_ip   = string
  }))
  default = [
    {
      name     = "default_rule" # TODO: Update the start and end IPs to be more restrictive
      start_ip = "0.0.0.0"
      end_ip   = "255.255.255.255"
    }
  ]
}

/**
variable "patch_schedule" {
  description = "The patch schedule for the Redis cache"
  type = object({
    day_of_week    = string
    start_hour_utc = number
  })
  default = {
    day_of_week    = "Saturday"
    start_hour_utc = 1
  }
}
*/