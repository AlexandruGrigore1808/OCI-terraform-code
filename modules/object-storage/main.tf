resource "oci_objectstorage_bucket" "test_bucket" {
  compartment_id = var.compartment_id
  name           = "my-backup"
  namespace      = "to-be-filled"
  access_type    = "NoPublicAccess"
  storage_tier   = "Archive"
  versioning     = "Enabled"

  freeform_tags = { "Automated" = "True" }
}