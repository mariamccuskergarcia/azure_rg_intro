
data "azurerm_log_analytics_workspace" "logging" {
  name                = var.logging_name
  resource_group_name = var.logging_resource_group_name
}
