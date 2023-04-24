module "route_table" {
  source   = "git::ssh://devops.scmservice.us-ashburn-1.oci.oraclecloud.com/namespaces/id9de6bj2yv6/projects/claro-devops/repositories/terraform-oci-route-table?ref=v0.3.4"
  for_each = var.route_tables

  display_name   = each.key
  compartment_id = data.oci_identity_compartments.network_cmp[each.key].compartments[0].id
  subnet_ids     = data.oci_core_subnets.subnets[each.key].subnets[*].id
  vcn_id         = data.oci_core_subnets.subnets[each.key].subnets[0].vcn_id
  # tags
  freeform_tags = lookup(each.value, "freeform_tags", {})
  defined_tags  = lookup(each.value, "defined_tags", {})

  rules = can(each.value["rules"]) ? each.value["rules"] : {}
}