data "oci_core_subnets" "subnets" {
  #Required
  compartment_id = var.compartment_id

  #Optional
  display_name = var.subnet_name
}