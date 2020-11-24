
# resource "azurerm_resource_group" "main" {
#   name     = var.resource_group_name
#   location = var.location

#   tags = var.tags
# }

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_cosmosdb_account" "main" {
  name                = "${var.name}-account"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = var.enable_automatic_failover

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = var.failover_location
    failover_priority = 1
  }

  geo_location {
    location          = data.azurerm_resource_group.main.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_mongo_database" "main" {
  name                = "${var.name}-mongo-db"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.main.name
  throughput          = 400
}


resource "azurerm_cosmosdb_mongo_collection" "main" {
  name                = "tfex-cosmos-mongo-db"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.main.name
  database_name       = azurerm_cosmosdb_mongo_database.main.name

  default_ttl_seconds = "777"
  shard_key           = "uniqueKey"
  throughput          = 400
}
