
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_servicebus_namespace" "main" {
  name                = "${var.name}-namespace"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_servicebus_topic" "main" {
  name                = "${var.name}-topic"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.main.name

  enable_partitioning = true
}

resource "azurerm_servicebus_topic_authorization_rule" "main" {
  name                = "${var.name}-authorization"
  namespace_name      = azurerm_servicebus_namespace.main.name
  topic_name          = azurerm_servicebus_topic.main.name
  resource_group_name = var.resource_group_name
  listen              = true
  send                = false
  manage              = false
}
