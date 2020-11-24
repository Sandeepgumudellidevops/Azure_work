resource "azurerm_servicebus_subscription" "main" {
  name                = "${var.name}-subscription"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.main.name
  topic_name          = azurerm_servicebus_topic.main.name
  max_delivery_count  = 1
}
