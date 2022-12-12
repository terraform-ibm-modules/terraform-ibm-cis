locals {
  record_set = [
    {
      name    = "test-exmple.loc"
      type    = "LOC"
      ttl     = 900
      content = "2001::4"
      data = {
        altitude       = 98
        lat_degrees    = 60
        lat_direction  = "N"
        lat_minutes    = 53
        lat_seconds    = 53
        long_degrees   = 45
        long_direction = "E"
        long_minutes   = 34
        long_seconds   = 34
        precision_horz = 56
        precision_vert = 64
        size           = 68
      }
    }
  ]
  origin_pools = [
    {
      name = "op1"
      origins = [{
        name    = "o-1"
        address = "1.1.1.0"
        enabled = true
        },
        {
          name    = "o-2"
          address = "1.1.1.4"
          enabled = true
      }]
      enabled       = true
      check_regions = ["WEU"]
      monitor_name  = "hc1"
    },
    {
      name = "op2"
      origins = [{
        name    = "o-1"
        address = "1.1.1.2"
        enabled = true
        },
        {
          name    = "o-2"
          address = "1.1.1.5"
          enabled = true
      }]
      enabled       = true
      check_regions = ["WEU"]
      monitor_name  = "hc1"
    },
    {
      name = "op3"
      origins = [{
        name    = "o-1"
        address = "1.1.1.3"
        enabled = true
        }
        , {
          name    = "o-2"
          address = "1.1.1.6"
          enabled = true
      }]
      enabled       = true
      check_regions = ["WEU"]
    }
  ]
  region_pools = [{
    region     = "WEU"
    pool_names = ["op1", "op3"]
  }]
  monitors = [
    {
      expected_body  = "alive"
      expected_codes = "2xx"
      method         = "GET"
      timeout        = 7
      path           = "/health"
      interval       = 60
      retries        = 3
      name           = "hc1"
    }
  ]
}
