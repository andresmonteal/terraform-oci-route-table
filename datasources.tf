data "oci_core_subnets" "subnets" {
  #Required
  compartment_id = var.compartment_id

  #Optional
  display_name = var.subnet_name
}

data "oci_core_drgs" "drg" {
  for_each = can(var.rules.drg_rules) ? { for idx, obj in var.rules.drg_rules : tostring(idx) => obj } : {}
  #Required
  compartment_id = var.compartment_id
  filter {
    name   = "display_name"
    values = [each.value["drg_name"]]
  }
}

data "oci_core_internet_gateways" "ig" {
  for_each = can(var.rules.ig_rules) ? { for idx, obj in var.rules.ig_rules : tostring(idx) => obj } : {}
  #Required
  compartment_id = var.compartment_id

  #Optional
  display_name = each.value["ig_name"]
}

data "oci_core_service_gateways" "sg" {
  for_each = can(var.rules.sg_rules) ? { for idx, obj in var.rules.sg_rules : tostring(idx) => obj } : {}
  #Required
  compartment_id = var.compartment_id

  #Optional
  filter {
    name   = "display_name"
    values = [each.value["sg_name"]]
  }
}