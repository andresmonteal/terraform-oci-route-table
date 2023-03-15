locals {
  default_freeform_tags = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-oci-route-table"
  }
  merged_freeform_tags = merge(var.freeform_tags, local.default_freeform_tags)
}

resource "oci_core_route_table" "main" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id == null ? data.oci_core_subnets.subnets.subnets[0].vcn_id : var.vcn_id

  #Optional
  display_name  = var.display_name
  defined_tags  = var.defined_tags
  freeform_tags = local.merged_freeform_tags

  /*   dynamic "route_rules" {
    for_each  = var.route_rules
    content {
      #network_entity_id = lookup(route_rules.value, "network_entity_id", "")
      network_entity_id = route_rules.value["type"] == "drg" ? var.drg_id : ""
      destination       = lookup(route_rules.value, "destination", "")
      destination_type  = lookup(route_rules.value, "destination_type", "CIDR_BLOCK")
    }
  } */

}

resource "oci_core_route_table_attachment" "main" {
  subnet_id      = var.subnet_id == null ? data.oci_core_subnets.subnets.subnets[0].id : var.subnet_id
  route_table_id = oci_core_route_table.main.id
}
