locals {

  prefix           = format("%s%s", var.prefix, var.pod)
  asp_name         = format("plan-%s-%s", random_string.random.result, local.prefix)
  asp_storage_name = format("stp%s", local.prefix)
  tags             = merge(tomap({ "pod" = var.pod }), var.tags)

  local_users_group_name = format("ce%02d Project Users", var.cohort)

}

data "azurerm_resource_group" "deploy" {
  name = var.resource_group_name
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_service_plan" "app_service" {
  name = local.asp_name

  resource_group_name = data.azurerm_resource_group.deploy.name
  location            = data.azurerm_resource_group.deploy.location
  os_type             = "Linux"
  sku_name            = "B1"
  tags                = local.tags
}


resource "azurerm_storage_account" "app_service" {
  name                      = local.asp_storage_name
  resource_group_name       = data.azurerm_resource_group.deploy.name
  location                  = data.azurerm_resource_group.deploy.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true
  tags                      = local.tags
}



data "azurerm_monitor_diagnostic_categories" "storage" {
  resource_id = azurerm_storage_account.app_service.id
}

resource "azurerm_monitor_diagnostic_setting" "storage" {
  name                       = local.asp_storage_name
  target_resource_id         = azurerm_storage_account.app_service.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logging.id

  dynamic "metric" {
    iterator = metric_category
    for_each = data.azurerm_monitor_diagnostic_categories.storage.metrics

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


data "azurerm_monitor_diagnostic_categories" "app_service" {
  resource_id = azurerm_service_plan.app_service.id
}

resource "azurerm_monitor_diagnostic_setting" "app_service" {
  name                       = local.asp_storage_name
  target_resource_id         = azurerm_service_plan.app_service.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logging.id

  dynamic "metric" {
    iterator = metric_category
    for_each = data.azurerm_monitor_diagnostic_categories.app_service.metrics

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