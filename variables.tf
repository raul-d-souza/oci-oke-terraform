variable "tenancy_ocid" {
    type = string
    default = ""
    description = "https://cloud.oracle.com/tenancy?region=your-region"
}

variable "compartment_id" {
    type = string
    default = ""
    description = "Compartment ID. You can find at Your Compartment Page."
}

variable "user_ocid" {
    type = string
    default = ""
    description = "https://cloud.oracle.com/identity/domains/my-profile?tenant=XXX&domain=XXX&region=XXX"
}

variable "region" {
    type = string
    default = ""
    description = "Your region"
}

variable "availability_domain"{
    type = string
    default = ""
    description = "AD"
}

variable "cluster_name"{
    type = string
    default = ""
    description = "Your Cluster Name"
}

variable "dns_name"{
    type = string
    default = ""
    description = "Only letters, 1 to 15 characters"
}

