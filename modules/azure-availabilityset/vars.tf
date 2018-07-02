variable "sdn_name" {}

variable "availabilityset_location" {}

variable "availability_rg" {}

variable "update_domain_count" {
	default = 5
}

variable "fault_domain_count" {
	default = 3
}

