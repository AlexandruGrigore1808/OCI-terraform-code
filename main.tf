module "vcn" {
  source         = "./modules/vcn"
  compartment_id = var.compartment_id
}

module "compute" {
  source            = "./modules/compute"
  compartment_id    = var.compartment_id
  public_subnet_id  = module.vcn.public_subnet_id
  private_subnet_id = module.vcn.private_subnet_id
  tenancy_id        = var.tenancy_id
  ssh_public_key    = var.ssh_public_key
}

module "object-storage" {
  source         = "./modules/object-storage"
  compartment_id = var.compartment_id
}