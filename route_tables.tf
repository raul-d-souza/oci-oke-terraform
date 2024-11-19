resource "oci_core_default_route_table" "generated_oci_core_default_route_table" {
  display_name = "oke-public-routetable-${var.cluster_name}"
  route_rules {
    description       = "traffic to/from internet"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.generated_oci_core_internet_gateway.id
  }
  manage_default_resource_id = oci_core_vcn.generated_oci_core_vcn.default_route_table_id
}


resource "oci_core_route_table" "generated_oci_core_route_table" {
  compartment_id = var.compartment_id
  display_name   = "oke-private-routetable-${var.cluster_name}"
  vcn_id         = oci_core_vcn.generated_oci_core_vcn.id

  route_rules {
    description       = "traffic to the internet"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.generated_oci_core_nat_gateway.id
  }

  route_rules {
    description       = "traffic to OCI services"
    destination       = "all-gru-services-in-oracle-services-network"
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.generated_oci_core_service_gateway.id
  }
}
