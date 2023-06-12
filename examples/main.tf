module "route_table" {
  source = "../"

  for_each = var.route_tables

  display_name = each.key
  tenancy_ocid = var.tenancy_ocid
  compartment  = each.value["compartment"]
  subnet_name  = each.value["subnet_name"]

  rules = each.value["rules"]
}