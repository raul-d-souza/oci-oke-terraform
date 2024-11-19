resource "oci_core_vcn" "generated_oci_core_vcn" {
  cidr_block      = "10.0.0.0/16"
  compartment_id  = var.compartment_id
  display_name    = "oke-vcn-${var.cluster_name}"
  dns_label       = var.dns_name
}
