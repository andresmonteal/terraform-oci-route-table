
# Copyright (c) 2019, 2021, Oracle Corporation and/or affiliates.

variable "tenancy_ocid" {
  description = "root compartment"
  default     = "tenancy-id"
}

# subnet parameters

variable "route_tables" {
  type = map(any)
}