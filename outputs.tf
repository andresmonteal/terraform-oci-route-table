output "id" {
  description = "ID do recurso"
  value       = oci_core_route_table.main.id
}

output "state" {
  description = "Estado do recurso"
  value       = oci_core_route_table.main.state
}

output "vcn_id" {
  description = "VCN ID do recurso"
  value       = oci_core_route_table.main.vcn_id
}

output "time_created" {
  description = "Hora da Criação do Recurso"
  value       = oci_core_route_table.main.time_created
}

output "route_rules_destination" {
  description = "Destino das Rotas"
  value       = oci_core_route_table.main.route_rules.*.destination
}


output "route_rules_destination_type" {
  description = "Tipo de Destino das Rotas"
  value       = oci_core_route_table.main.route_rules.*.destination_type
}

output "route_rules_network_entity_id" {
  description = "Network Entity ID das Rotas"
  value       = oci_core_route_table.main.route_rules.*.network_entity_id
}

output "compartment_id" {
  description = "Compartment ID do recurso"
  value       = oci_core_route_table.main.compartment_id
}

output "display_name" {
  description = "Nome de Exibição do recurso"
  value       = oci_core_route_table.main.display_name
}


output "subnet_id" {
  description = "Subnet ID do recurso"
  value       = oci_core_route_table_attachment.main.*.subnet_id
}

output "route_table_id" {
  description = "Route Table ID"
  value       = oci_core_route_table_attachment.main.*.route_table_id
}
