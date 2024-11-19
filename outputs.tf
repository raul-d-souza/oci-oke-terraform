output "vcn_id" {
  value = oci_core_vcn.generated_oci_core_vcn.id
}

output "oke_cluster_id" {
  value = oci_containerengine_cluster.generated_oci_containerengine_cluster.id
}

output "node_pool_id" {
  value = oci_containerengine_node_pool.create_node_pool_details0.id
}
