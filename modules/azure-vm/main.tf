######################################################################
# Copyright 2018, Toyota, TMNA
# This file is subject to the terms and conditions defined in
# file 'LICENSE', which is part of this source code package.
######################################################################

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.sdn_name}"
  location = "${var.location}"

  tags {
    Namespace = "${var.sdn_name}"
    ManagedBy = "Terrafrom"
  }
}

resource "azurerm_network_interface" "main" {
  name                = "nwi-${var.sdn_name}"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  ip_configuration {
    name                          = "ip-${var.sdn_name}-main"
    subnet_id                     = "${data.azurerm_subnet.main.id}"
    private_ip_address_allocation = "dynamic"
  }

  tags {
    Namespace = "${var.sdn_name}"
    ManagedBy = "Terrafrom"
  }
}

resource "azurerm_managed_disk" "main" {
  name                 = "disk-${var.sdn_name}-data1"
  location             = "${azurerm_resource_group.main.location}"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "${var.vm_data_disk_size}"
}

resource "azurerm_virtual_machine" "main" {
  name                  = "vm-${var.sdn_name}"
  location              = "${azurerm_resource_group.main.location}"
  availability_set_id   = "${var.availabilityset_id}"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  network_interface_ids = ["${azurerm_network_interface.main.id}"]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "${var.vm_os_image_publisher}"
    offer     = "${var.vm_os_image_offer}"
    sku       = "${var.vm_os_image_sku}"
    version   = "${var.vm_os_image_version}"
  }

  storage_os_disk {
    name              = "disk-${var.sdn_name}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_data_disk {
    name            = "${azurerm_managed_disk.main.name}"
    managed_disk_id = "${azurerm_managed_disk.main.id}"
    create_option   = "Attach"
    lun             = 0
    disk_size_gb    = "${azurerm_managed_disk.main.disk_size_gb}"
  }

  os_profile {
    computer_name  = "${var.sdn_name}"
    admin_username = "${var.vm_admin_username}"
    admin_password = "${var.vm_admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags {
    Namespace = "${var.sdn_name}"
    ManagedBy = "Terraform"
  }
}
