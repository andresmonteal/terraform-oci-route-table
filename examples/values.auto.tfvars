tenancy_ocid = "tenant-id"

route_tables = {
  "rt-db-np-pri-sicop" = {
    subnet_name = "sn-app-np-pri-sicop"
    compartment = "cmp-networking"
    rules = {
      ng_rules = [{
        ng_name     = "nat-gateway"
        description = "all addresses to nat gateway"
        destination = "0.0.0.0/0"
      }]
    }
  }
}