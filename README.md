# OCI Compartment Terraform Module

This Terraform module provisions an Oracle Cloud Infrastructure (OCI) compartment and its related resources.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Files](#files)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) 0.12 or later
- Oracle Cloud Infrastructure account credentials

## Usage

To use this module, include the following code in your Terraform configuration:

```hcl
module "oci_compartment" {
  source = "path_to_this_module"

  # Define the necessary variables
  tenancy_ocid     = var.tenancy_ocid
  compartment_id   = var.compartment_id
  compartment      = var.compartment
  name             = var.name
  freeform_tags    = var.freeform_tags
  defined_tags     = var.defined_tags
}
```

## Files

- `variables.tf`: Defines input variables.
- `main.tf`: Main Terraform configuration for setting up the compartment.
- `output.tf`: Defines output values to be exported.
- `subfolder/main.tf`: Configuration for DRG attachment.

### variables.tf

```hcl
variable "tenancy_ocid" {
  description = "(Required) (Updatable) The OCID of the root compartment."
  type        = string
  default     = null
}

variable "compartment_id" {
  description = "Compartment id where to create all resources."
  type        = string
  default     = null
}

variable "compartment" {
  description = "Compartment name where to create all resources."
  type        = string
  default     = null
}

variable "name" {
  description = "(Required) The name you assign to the tag namespace during creation. It must be unique across all tag namespaces in the tenancy and cannot be changed."
  type        = string
}

variable "freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace."
  type        = map(any)
  default     = null
}

variable "defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace."
  type        = map(any)
  default     = null
}
```

### main.tf

```hcl
locals {
  default_freeform_tags = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-oci-compartment"
  }
  merged_freeform_tags = merge(var.freeform_tags, local.default_freeform_tags)
  compartment_id       = try(data.oci_identity_compartments.compartment[0].compartments[0].id, var.compartment_id)
}

resource "oci_identity_compartment" "main" {
  compartment_id = local.compartment_id

  defined_tags  = var.defined_tags
  display_name  = var.name
  freeform_tags = local.merged_freeform_tags

  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }
}
```

### output.tf

```hcl
output "id" {
  description = "Resource id"
  value       = oci_identity_compartment.main.id
}

output "compartment_id" {
  description = "Resource compartment_id id"
  value       = oci_identity_compartment.main.compartment_id
}
```

### subfolder/main.tf

```hcl
resource "oci_core_drg_attachment" "main" {
  drg_id = local.drg_id

  defined_tags  = var.defined_tags
  display_name  = "att-${var.drg_name}"
  freeform_tags = local.merged_freeform_tags
  network_details {
    id   = local.vcn_id
    type = "VCN"

    route_table_id = var.route_table_id
    vcn_route_type = "VCN_CIDRS"
  }
}
```

## Inputs

| Name            | Description                                                                 | Type       | Default | Required |
|-----------------|-----------------------------------------------------------------------------|------------|---------|----------|
| tenancy_ocid    | (Required) (Updatable) The OCID of the root compartment.                    | `string`   | `null`  | yes      |
| compartment_id  | Compartment id where to create all resources.                               | `string`   | `null`  | yes      |
| compartment     | Compartment name where to create all resources.                             | `string`   | `null`  | yes      |
| name            | (Required) The name you assign to the tag namespace during creation.        | `string`   | n/a     | yes      |
| freeform_tags   | (Optional) (Updatable) Free-form tags for this resource.                    | `map(any)` | `null`  | no       |
| defined_tags    | (Optional) (Updatable) Defined tags for this resource.                      | `map(any)` | `null`  | no       |

## Outputs

| Name           | Description                              |
|----------------|------------------------------------------|
| id             | The ID of the created compartment        |
| compartment_id | The compartment ID of the created compartment  |

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any bugs, feature requests, or enhancements.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.