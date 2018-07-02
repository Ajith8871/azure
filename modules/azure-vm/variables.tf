variable "sdn_name" {
  description = "Namespace used to prefix all resource names. e.g. project-env"
}

variable "location" {
  description = "Region"
  default     = "eastus"
}

variable "vm_data_disk_size" {
  description = "Disk Size"
  default     = "1024"
}

variable "vm_os_image_publisher" {}

variable "vm_os_image_offer" {}

variable "vm_os_image_sku" {}

variable "vm_os_image_version" {}

variable "vm_admin_username" {}

variable "vm_admin_password" {}

variable "subnet_name" {}

variable "subnet_vnet_name" {}

variable "subnet_rg_name" {}

variable "availabilityset_id" {}
