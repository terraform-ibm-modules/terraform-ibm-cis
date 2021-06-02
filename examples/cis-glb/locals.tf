locals {
  origin_pools = [
    {
      name = "${var.pool_name}-1"
      origins = [{
        name    = "${var.origin_server}-1"
        address = element(var.server_address, 0)
        enabled = false
      }]
      enabled = false
    },
    {
      name = "${var.pool_name}-2"
      origins = [{
        name    = "${var.origin_server}-2"
        address = element(var.server_address, 1)
        enabled = false
      }]
      enabled = false
    },
    {
      name = "${var.pool_name}-3"
      origins = [{
        name    = "${var.origin_server}-3"
        address = element(var.server_address, 3)
        enabled = false
      }]
      enabled = false

    }
  ]
}
