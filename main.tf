provider "azurerm" {}

module "vnet" {
  source = "modules/azure-vnet"

  sdn_name           = "${var.sdn_name}"
  location           = "${var.location}"
  vnet_cidr          = "10.0.0.0/16"
  vnet_private1_cidr = "10.0.1.0/24"
}

module "availabilityset" {
  source                   = "modules/azure-availabilityset"

  sdn_name                 = "${var.sdn_name}"
  availabilityset_location = "${var.location}"
  availability_rg       = "${module.vnet.rg_name}"
}


module "vm" {
  source = "modules/azure-vm"

  sdn_name              = "${var.sdn_name}"
  location              = "${var.location}"
  vm_data_disk_size     = "${var.vm_data_disk_size}"
  vm_os_image_publisher = "${var.vm_os_image_publisher}"
  vm_os_image_offer     = "${var.vm_os_image_offer}"
  vm_os_image_sku       = "${var.vm_os_image_sku}"
  vm_os_image_version   = "${var.vm_os_image_version}"
  vm_admin_username     = "${var.vm_admin_username}"
  vm_admin_password     = "${var.vm_admin_password}"
  subnet_name           = "${module.vnet.subnet_name}"
  subnet_vnet_name      = "${module.vnet.vnet_name}"
  subnet_rg_name        = "${module.vnet.rg_name}"
  availabilityset_id    = "${module.availabilityset.availabilityset_id}"
}
