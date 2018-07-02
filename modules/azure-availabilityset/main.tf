resource "azurerm_availability_set" "main" {
  name                         = "as-${var.sdn_name}"
  location                     = "${var.availabilityset_location}"
  resource_group_name          = "${var.availability_rg}"
  platform_update_domain_count = "${var.update_domain_count}"
  platform_fault_domain_count  = "${var.fault_domain_count}"
  managed                      = true

  tags {
	Namespace = "${var.sdn_name}"	
	ManagedBy = "Terraform"
  }
}
