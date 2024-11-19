data "oci_core_services" "oci_services" {
}

resource "oci_core_internet_gateway" "generated_oci_core_internet_gateway" {
  compartment_id = var.compartment_id
  display_name   = "oke-igw-${var.cluster_name}"
  enabled        = "true"
  vcn_id         = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_nat_gateway" "generated_oci_core_nat_gateway" {
  compartment_id = var.compartment_id
  display_name   = "oke-ngw-${var.cluster_name}"
  vcn_id         = "${oci_core_vcn.generated_oci_core_vcn.id}"
}

resource "oci_core_service_gateway" "generated_oci_core_service_gateway" {
  compartment_id = var.compartment_id
  display_name   = "oke-sgw-${var.cluster_name}"
  services {
    service_id = data.oci_core_services.oci_services.services[0].id
  }
   vcn_id         = "${oci_core_vcn.generated_oci_core_vcn.id}"
}


