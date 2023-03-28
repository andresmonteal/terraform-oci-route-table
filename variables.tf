variable "compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to contain the route table."
}

variable "subnet_name" {
  description = "(Required) The name of the subnet."
  default     = ""
  type        = string
}

variable "subnet_ids" {
  description = "(Required) The OCID of the subnet."
  default     = []
  type        = list(string)
}

variable "vcn_id" {
  description = "(Required) The OCID of the VCN the route table belongs to."
  default     = ""
  type        = string
}

variable "display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = ""
  type        = string
}

variable "freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace."
  default     = {}
  type        = map(any)
}

variable "defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace."
  default     = {}
  type        = map(any)
}

variable "rules" {
  description = "(Optional) (Updatable) The collection of rules used for routing destination IPs to network devices."
  default     = {}
  type        = map(any)
}