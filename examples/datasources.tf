data "oci_identity_compartments" "network_cmp" {

  for_each = var.route_tables
  #Required
  compartment_id = var.tenancy_ocid

  #Optional
  name = each.value["network_cmp"]
}

data "oci_core_subnets" "subnets" {
  for_each = var.route_tables

  #Required
  compartment_id = data.oci_identity_compartments.network_cmp[each.key].compartments[0].id

  #Optional
  filter {
    name   = "display_name"
    values = each.value["subnets"]
  }
}