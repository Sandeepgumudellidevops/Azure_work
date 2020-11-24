resource "azurerm_servicebus_queue" "main" {
  name                = "${var.name}-queue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.main.name

  enable_partitioning = true
}
