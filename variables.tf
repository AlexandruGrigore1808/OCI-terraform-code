variable "compartment_id" {
  type    = string
  default = "to-be-filled"
}

variable "ssh_public_key" {
  description = "The Public ssh key used to connect to the core instance"
  type        = string
  default     = "to-be-filled"
}

variable "tenancy_id" {
  type    = string
  default = "to-be-filled"
}
