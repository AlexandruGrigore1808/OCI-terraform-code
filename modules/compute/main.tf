resource "oci_core_instance" "public" {
  availability_domain = data.oci_identity_availability_domains.main.availability_domains[0].name
  compartment_id      = var.compartment_id

  shape        = "VM.Standard.E2.1.Micro"
  display_name = "Public Host"

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.public_subnet_id
  }

  source_details {
    boot_volume_size_in_gbs = 50
    source_type             = "image"
    source_id               = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaprt6uk32tylin3owcddyllao3uthmo7vheqepeybvjj6to7xkdgq"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  freeform_tags = { "Automated" = "True" }
}


resource "oci_core_volume" "public-compute" {
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.main.availability_domains[0].name
  display_name        = "Core Volume"
  size_in_gbs         = 50

  freeform_tags = { "Automated" = "True" }
}

resource "oci_core_volume_attachment" "public-compute" {
  attachment_type = "iscsi"
  instance_id     = oci_core_instance.public.id
  volume_id       = oci_core_volume.public-compute.id
}

resource "oci_core_instance" "private" {
  availability_domain = data.oci_identity_availability_domains.main.availability_domains[0].name
  compartment_id      = var.compartment_id

  shape        = "VM.Standard.E2.1.Micro"
  display_name = "Private Host"

  create_vnic_details {
    assign_public_ip = false
    subnet_id        = var.private_subnet_id
  }

  source_details {
    boot_volume_size_in_gbs = 50
    source_type             = "image"
    source_id               = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaprt6uk32tylin3owcddyllao3uthmo7vheqepeybvjj6to7xkdgq"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  freeform_tags = { "Automated" = "True" }
}