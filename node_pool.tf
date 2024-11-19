# Data source para buscar a imagem mais recente
data "oci_core_images" "latest_image" {
  compartment_id           = var.compartment_id
  operating_system         = "Oracle Linux"        # Substitua pelo seu sistema operacional desejado
  operating_system_version = "8"                   # Versão do sistema operacional, se aplicável
  shape                    = "VM.Standard.E5.Flex" # Defina o shape ou remova se não for necessário

  # Ordenar por tempo de criação (opcional, mas útil para pegar a mais recente)
  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}

resource "oci_containerengine_node_pool" "create_node_pool_details0" {
  cluster_id     = oci_containerengine_cluster.generated_oci_containerengine_cluster.id
  compartment_id = var.compartment_id

  freeform_tags = {
    "OKEnodePoolName" = "pool-${var.cluster_name}"
  }

  initial_node_labels {
    key   = "name"
    value = var.cluster_name
  }

  kubernetes_version = "v1.30.1"
  name               = "pool-${var.cluster_name}"

  node_config_details {
    freeform_tags = {
      "OKEnodePoolName" = "pool-${var.cluster_name}"
    }
    node_pool_pod_network_option_details {
      cni_type       = "OCI_VCN_IP_NATIVE"
      pod_subnet_ids = [oci_core_subnet.node_subnet.id]
    }

    placement_configs {
      availability_domain = "IAfA:${var.availability_domain}"
      subnet_id           = oci_core_subnet.node_subnet.id
    }
    size = "3"
  }

  node_eviction_node_pool_settings {
    eviction_grace_duration = "PT60M"
  }

  node_shape = "VM.Standard.E5.Flex"

  node_shape_config {
    memory_in_gbs = "32"
    ocpus         = "2"
  }

  node_source_details {
    image_id    = data.oci_core_images.latest_image.images[0].id
    source_type = "IMAGE"
  }
}
