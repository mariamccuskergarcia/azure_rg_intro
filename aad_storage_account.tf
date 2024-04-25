locals {
  aad_storage_name = format("sta%s", local.prefix)
}

resource "azurerm_storage_account" "adls_gen2" {
  name                      = local.aad_storage_name
  resource_group_name       = azurerm_resource_group.deploy.name
  location                  = azurerm_resource_group.deploy.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true
  is_hns_enabled            = "true"

  tags = local.default_tags
}

resource "azurerm_storage_container" "group" {
  name                  = "group"
  storage_account_name  = azurerm_storage_account.adls_gen2.name
  container_access_type = "private"
}



data "azurerm_monitor_diagnostic_categories" "adls_gen2" {
  resource_id = azurerm_storage_account.adls_gen2.id
}

resource "azurerm_monitor_diagnostic_setting" "adls_gen2" {
  name                       = local.aad_storage_name
  target_resource_id         = azurerm_storage_account.adls_gen2.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logging.id

  dynamic "metric" {
    iterator = metric_category
    for_each = data.azurerm_monitor_diagnostic_categories.adls_gen2.metrics

    content {
      category = metric_category.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 90
      }
    }
  }
}

data "azuread_group" "aad_users" {
  display_name = local.local_users_group_name
}

resource "azurerm_role_assignment" "data_key_service_role" {
  scope                = azurerm_resource_group.deploy.id
  role_definition_name = "Storage Account Key Operator Service Role"
  principal_id         = data.azuread_group.aad_users.object_id

}