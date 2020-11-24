data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}


resource "azurerm_storage_account" "main" {
  name                     = "${var.name}-storage-account"
  resource_group_name      = var.resource_group_name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "main" {
  name                = "${var.name}-service-plan"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "main" {
  name                       = "${var.name}-function"
  location                   = data.azurerm_resource_group.main.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_app_service_plan.main.id
  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
}
