## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.28.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.21.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.28.1 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.21.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_service"></a> [app\_service](#module\_app\_service) | ./tf_app_service | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.adls_gen2](https://registry.terraform.io/providers/hashicorp/azurerm/3.21.1/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_resource_group.deploy](https://registry.terraform.io/providers/hashicorp/azurerm/3.21.1/docs/resources/resource_group) | resource |
| [azurerm_resource_group.team](https://registry.terraform.io/providers/hashicorp/azurerm/3.21.1/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.data_key_service_role](https://registry.terraform.io/providers/hashicorp/azurerm/3.21.1/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.adls_gen2](https://registry.terraform.io/providers/hashicorp/azurerm/3.21.1/docs/resources/storage_account) | resource |
| [azurerm_storage_container.group](https://registry.terraform.io/providers/hashicorp/azurerm/3.21.1/docs/resources/storage_container) | resource |
| [azuread_group.aad_users](https://registry.terraform.io/providers/hashicorp/azuread/2.28.1/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.21.1/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.logging](https://registry.terraform.io/providers/hashicorp/azurerm/3.21.1/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_diagnostic_categories.adls_gen2](https://registry.terraform.io/providers/hashicorp/azurerm/3.21.1/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cohort"></a> [cohort](#input\_cohort) | n/a | `number` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_id"></a> [id](#input\_id) | n/a | `number` | n/a | yes |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | n/a | `number` | `0` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_pods"></a> [pods](#input\_pods) | Collection of pods | `set(string)` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
