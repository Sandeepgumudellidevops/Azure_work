terraform {
  required_version = ">= 0.12.6"
}

provider "azurerm" {
  version = "~> 2.34.0"
  features {}
}


module "cosmosdb" {
    source     = "./modules/cosmosdb"
    name                = "cosmosdb"
    resource_group_name = "cosmosdb-name"
    enable_automatic_failover = false
    failover_location       = ""

    tags = {
    tag1 = "value1"
    }
}


module "servicebus" {
    source     = "./modules/servicebus"
    name                = "topicname"
    resource_group_name = "resourcegroup-name"

    tags = {
    tag1 = "value1"
    }
}

module "lambda" {
    source     = "./modules/servicebus"
    name                = "lambdaa-name"
    resource_group_name = "resourcegroup-name"

    tags = {
    tag1 = "value1"
    }
}
