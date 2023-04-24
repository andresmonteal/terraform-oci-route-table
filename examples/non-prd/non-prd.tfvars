route_tables = {
  "ROUTE-TABLE-NAME" = {
    network_cmp  = "NETWORKING"
    defined_tags = { "NAMESPACE.TAG" = "VALUE", "NAMESPACE.TAG" = "VALUE-2" }
    subnets      = ["SUBNET-1", "SUBNET-2", "SUBNET-3"]
    rules = {
      drg_rules = [{
        drg_name    = "DRG-NAME"
        destination = "0.0.0.0/0"
        description = "all addresses to drg"
        }
      ],
      sg_rules = [{
        sg_name     = "SERVICE-GATEWAY-NAME"
        description = "all addresses to svg"
        }
      ]
    }
  },
  "ROUTE-TABLE-NAME-02" = {
    network_cmp  = "NETWORKING"
    defined_tags = { "NAMESPACE.TAG" = "VALUE", "NAMESPACE.TAG" = "VALUE-2" }
    subnets      = ["SUBNET-1", "SUBNET-2", "SUBNET-3"]
    rules = {
      drg_rules = [{
        drg_name    = "DRG-NAME"
        destination = "0.0.0.0/0"
        description = "all addresses to drg"
        }
      ],
      sg_rules = [{
        sg_name     = "SERVICE-GATEWAY-NAME"
        description = "all addresses to svg"
        }
      ]
    }
  }
}