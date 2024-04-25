locals {
  azurerm_resource_group_name = format("rg-%s", local.prefix)
}

resource "azurerm_resource_group" "deploy" {
  name     = local.azurerm_resource_group_name
  location = var.location
  tags     = local.default_tags
}


resource "azurerm_role_assignment" "app_insights_contributor" {
  scope                = azurerm_resource_group.deploy.id
  role_definition_name = "Application Insights Component Contributor"
  principal_id         = data.azuread_group.aad_users.id
}


resource "azurerm_role_assignment" "website_contributor" {
  scope                = azurerm_resource_group.deploy.id
  role_definition_name = "Website Contributor"
  principal_id         = data.azuread_group.aad_users.id
}

