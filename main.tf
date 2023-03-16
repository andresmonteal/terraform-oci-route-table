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

  # rules to drg
  dynamic "route_rules" {
    for_each = can(var.rules.drg_rules) ? { for idx, obj in var.rules.drg_rules : tostring(idx) => obj } : {}
    content {
      network_entity_id = data.oci_core_drgs.drg[route_rules.key].drgs[0].id
      destination       = lookup(route_rules.value, "destination", "")
      destination_type  = "CIDR_BLOCK"
      description       = lookup(route_rules.value, "description", "")
    }
  }

  # rules to internet gateway
  dynamic "route_rules" {
    for_each = can(var.rules.ig_rules) ? { for idx, obj in var.rules.ig_rules : tostring(idx) => obj } : {}
    content {
      network_entity_id = data.oci_core_internet_gateways.ig[route_rules.key].gateways[0].id
      destination       = lookup(route_rules.value, "destination", "")
      destination_type  = "CIDR_BLOCK"
      description       = lookup(route_rules.value, "description", "")
    }
  }
}

resource "oci_core_route_table_attachment" "main" {
  subnet_id      = var.subnet_id == null ? data.oci_core_subnets.subnets.subnets[0].id : var.subnet_id
  route_table_id = oci_core_route_table.main.id
}