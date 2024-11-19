resource "oci_core_subnet" "service_lb_subnet" {
  cidr_block                    = "10.0.20.0/24"
  compartment_id                = var.compartment_id
  display_name                  = "oke-svclbsubnet-quick-${var.cluster_name}-regional"
  prohibit_public_ip_on_vnic    = "false"
  route_table_id                = oci_core_default_route_table.generated_oci_core_default_route_table.id
  security_list_ids             = [oci_core_vcn.generated_oci_core_vcn.default_security_list_id]
  vcn_id                        = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_subnet" "node_subnet" {
  cidr_block                    = "10.0.10.0/24"
  compartment_id                = var.compartment_id
  display_name                  = "oke-nodesubnet-quick-${var.cluster_name}-regional"
  prohibit_public_ip_on_vnic    = "true"
  route_table_id                = oci_core_route_table.generated_oci_core_route_table.id
  security_list_ids             = [oci_core_security_list.node_sec_list.id]
  vcn_id                        = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_subnet" "kubernetes_api_endpoint_subnet" {
  cidr_block                    = "10.0.0.0/28"
  compartment_id                = var.compartment_id
  display_name                  = "oke-k8sApiEndpoint-subnet-quick-${var.cluster_name}-regional"
  prohibit_public_ip_on_vnic    = "false"
  route_table_id                = oci_core_default_route_table.generated_oci_core_default_route_table.id
  security_list_ids             = [oci_core_security_list.kubernetes_api_endpoint_sec_list.id]
  vcn_id                        = oci_core_vcn.generated_oci_core_vcn.id
}
