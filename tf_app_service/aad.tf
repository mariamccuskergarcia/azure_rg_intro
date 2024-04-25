data "azuread_group" "aad_users" {
  display_name = local.local_users_group_name
}

resource "azurerm_role_assignment" "data_key_service_role" {
  scope                = azurerm_storage_account.app_service.id
  role_definition_name = "Storage Account Key Operator Service Role"
  principal_id         = data.azuread_group.aad_users.object_id
  depends_on = [
    azurerm_service_plan.app_service
  ]
}




resource "azurerm_role_assignment" "appservice_contributor" {
  scope                = azurerm_service_plan.app_service.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_group.aad_users.object_id
  depends_on = [
    azurerm_service_plan.app_service
  ]
}

resource "azurerm_role_assignment" "appservice_website_contributor" {
  scope                = azurerm_service_plan.app_service.id
  role_definition_name = "Website Contributor"
  principal_id         = data.azuread_group.aad_users.object_id

  depends_on = [
    azurerm_service_plan.app_service
  ]
}
