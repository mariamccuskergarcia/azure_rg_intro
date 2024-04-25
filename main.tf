locals {
  instance                    = format("%03d", var.instance_id)
  prefix                      = format("%s%sce%02d%01d%s", var.prefix, var.env, var.cohort, var.id, var.purpose)
  logging_resource_group_name = format("rg-kubce%02d-hub", var.cohort)
  logging_name                = format("log-ce%02d-00", var.cohort)
  local_users_group_name      = format("ce%02d Project Users", var.cohort)

  default_tags = tomap({
    "cohort"  = format("ce%02d", var.cohort),
    "env"     = var.env,
    "purpose" = var.purpose
    }
  )
}

terraform {
  backend "azurerm" {
  }
}

data "azurerm_log_analytics_workspace" "logging" {
  name                = local.logging_name
  resource_group_name = local.logging_resource_group_name
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "team" {
  name     = local.azurerm_resource_group_name
  location = var.location
  tags     = local.default_tags
}

module "app_service" {
  source                      = "./tf_app_service"
  resource_group_name         = azurerm_resource_group.deploy.name
  prefix                      = local.prefix
  cohort                      = var.cohort
  tags                        = local.default_tags
  for_each                    = var.pods
  pod                         = each.key
  logging_resource_group_name = local.logging_resource_group_name
  logging_name                = local.logging_name


  depends_on = [
    azurerm_resource_group.deploy
  ]
}
