output "rg_name" {
  value = "${azurerm_resource_group.main.name}"
}

output "vnet_name" {
  value = "${azurerm_virtual_network.main.name}"
}

output "subnet_name" {
  value = "${azurerm_subnet.main.name}"
}
