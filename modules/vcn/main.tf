resource "oci_core_vcn" "main" {
  compartment_id = var.compartment_id
  cidr_blocks    = ["10.0.0.0/16"]
  display_name   = "Main VCN"

  freeform_tags = { "Automated" = "True" }
}

resource "oci_core_subnet" "public" {
  cidr_block     = "10.0.0.0/24"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.main.id
  display_name   = "Public subnet"
  route_table_id = oci_core_route_table.public.id

  freeform_tags = { "Automated" = "True" }
}

resource "oci_core_subnet" "private" {
  cidr_block                 = "10.0.1.0/24"
  compartment_id             = var.compartment_id
  vcn_id                     = oci_core_vcn.main.id
  display_name               = "Private subnet"
  route_table_id             = oci_core_route_table.private.id
  prohibit_public_ip_on_vnic = true

  freeform_tags = { "Automated" = "True" }
}

resource "oci_core_internet_gateway" "main" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.main.id
  display_name   = "Main Internet Gateway"

  freeform_tags = { "Automated" = "True" }
}

resource "oci_core_nat_gateway" "main" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.main.id

  freeform_tags = { "Automated" = "True" }
}

resource "oci_core_route_table" "public" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.main.id
  display_name   = "Public Route Table"

  route_rules {
    network_entity_id = oci_core_internet_gateway.main.id
    destination       = "0.0.0.0/0"
  }

  freeform_tags = { "Automated" = "True" }
}

resource "oci_core_route_table" "private" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.main.id
  display_name   = "Private Route Table"

  route_rules {
    network_entity_id = oci_core_nat_gateway.main.id
    destination       = "0.0.0.0/0"
  }

  freeform_tags = { "Automated" = "True" }
}

