data "oci_identity_compartments" "compartment" {
  count = var.tenancy_ocid == null ? 0 : 1
  #Required
  compartment_id            = var.tenancy_ocid
  access_level              = "ANY"
  compartment_id_in_subtree = true

  #Optional
  filter {
    name   = "state"
    values = ["ACTIVE"]
  }

  filter {
    name   = "name"
    values = [var.compartment]
  }
}

data "oci_core_subnets" "subnets" {
  count = var.tenancy_ocid == null ? 0 : 1
  #Required
  compartment_id = local.compartment_id

  #Optional
  display_name = var.subnet_name
}

data "oci_core_drgs" "drg" {
  for_each = can(var.rules.drg_rules) ? { for idx, obj in var.rules.drg_rules : tostring(idx) => obj } : {}
  #Required
  compartment_id = local.compartment_id

  filter {
    name   = "display_name"
    values = [each.value["drg_name"]]
  }
}

data "oci_core_internet_gateways" "ig" {
  for_each = can(var.rules.ig_rules) ? { for idx, obj in var.rules.ig_rules : tostring(idx) => obj } : {}
  #Required
  compartment_id = local.compartment_id

  #Optional
  display_name = each.value["ig_name"]
  vcn_id       = try(data.oci_core_subnets.subnets[0].subnets[0].vcn_id, var.vcn_id)
}

data "oci_core_service_gateways" "sg" {
  for_each = can(var.rules.sg_rules) ? { for idx, obj in var.rules.sg_rules : tostring(idx) => obj } : {}
  #Required
  compartment_id = local.compartment_id

  #Optional
  vcn_id = try(data.oci_core_subnets.subnets[0].subnets[0].vcn_id, var.vcn_id)

  #Optional
  filter {
    name   = "display_name"
    values = [each.value["sg_name"]]
  }
}

data "oci_core_nat_gateways" "ng" {
  for_each = can(var.rules.ng_rules) ? { for idx, obj in var.rules.ng_rules : tostring(idx) => obj } : {}
  #Required
  compartment_id = local.compartment_id

  #Optional
  vcn_id = try(data.oci_core_subnets.subnets[0].subnets[0].vcn_id, var.vcn_id)

  #Optional
  filter {
    name   = "display_name"
    values = [each.value["ng_name"]]
  }
}

data "oci_core_services" "all_oci_services" {

  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
  count = can(var.rules.sg_rules) ? 1 : 0
}