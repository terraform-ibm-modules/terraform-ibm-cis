resource "ibm_cis_global_load_balancer" "cis_glb" {
  cis_id           = var.cis_id
  domain_id        = var.domain_id
  name             = var.glb_name
  fallback_pool_id = (var.fallback_pool_id == null ? ibm_cis_origin_pool.origin_pool[var.fallback_pool_name].id : var.fallback_pool_id)
  default_pool_ids = (var.default_pool_ids == null ? [for pool in ibm_cis_origin_pool.origin_pool : pool.id] : var.default_pool_ids)
  description      = (var.glb_description != null ? var.glb_description : null)
  proxied          = (var.glb_proxied != null ? var.glb_proxied : null)
  session_affinity = (var.session_affinity != null ? var.session_affinity : null)
  ttl              = (var.ttl != null ? var.ttl : null)
  enabled          = (var.glb_enabled != null ? var.glb_enabled : null)
  dynamic region_pools {
    for_each = var.region_pools
    content {
      region   = region_pools.value.region
      pool_ids = lookup(region_pools.value, "pool_names", null) != null ? [for pool in lookup(region_pools.value, "pool_names") : ibm_cis_origin_pool.origin_pool[pool].id] : lookup(region_pools.value, "pool_ids", null)
    }
  }
  dynamic pop_pools {
    for_each = var.pop_pools
    content {
      pop      = region_pools.value.pop
      pool_ids = lookup(region_pools.value, "pool_names", null) != null ? [for pool in lookup(region_pools.value, "pool_names") : ibm_cis_origin_pool.origin_pool[pool].id] : lookup(region_pools.value, "pool_ids", null)
    }
  }
}

resource "ibm_cis_origin_pool" "origin_pool" {
  cis_id   = var.cis_id
  for_each = { for pool in var.origin_pools : pool.name => pool }
  name     = each.value.name
  dynamic origins {
    for_each = lookup(each.value, "origins")
    content {
      name    = origins.value.name
      address = origins.value.address
      enabled = origins.value.enabled
      weight  = lookup(origins.value, "weight", null)
    }
  }
  check_regions      = lookup(each.value, "check_regions", [])
  description        = lookup(each.value, "description", null)
  enabled            = lookup(each.value, "enabled", null)
  minimum_origins    = lookup(each.value, "minimum_origins", null)
  notification_email = lookup(each.value, "notification_email", null)
  monitor            = (lookup(each.value, "monitor_name", null) != null ? ibm_cis_healthcheck.health_check[lookup(each.value, "monitor_name")].id : lookup(each.value, "monitor_id", null))
}


resource "ibm_cis_healthcheck" "health_check" {
  cis_id           = var.cis_id
  for_each         = { for monitor in var.monitors : monitor.name => monitor }
  description      = each.value.name
  path             = lookup(each.value, "path", "/")
  type             = lookup(each.value, "type", "http")
  port             = lookup(each.value, "port", null)
  expected_body    = lookup(each.value, "expected_body", null)
  expected_codes   = each.value.expected_codes
  method           = lookup(each.value, "method", "GET")
  timeout          = lookup(each.value, "timeout", 5)
  follow_redirects = lookup(each.value, "follow_redirects", false)
  allow_insecure   = lookup(each.value, "allow_insecure", false)
  interval         = lookup(each.value, "interval", 60)
  retries          = lookup(each.value, "retries", 2)

  dynamic headers {
    for_each = lookup(each.value, "headers", [])
    content {
      header = lookup(headers.value, "header", null)
      values = lookup(headers.value, "values", null)
    }
  }
}

