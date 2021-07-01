data "oci_identity_availability_domains" "main" {
  compartment_id = var.tenancy_id
}