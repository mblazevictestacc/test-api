# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

locals {
  stack      = "${var.app}-${var.env}"
  image_repo = "docker.io/${var.image}"

  default_tags = {
    environment = var.env
    owner       = "Me"
    app         = var.app
  }
}


resource "azurerm_resource_group" "hello_app" {
  name     = "rg-${local.stack}"
  location = var.region

  tags = local.default_tags
}


resource "azurerm_log_analytics_workspace" "hello_app" {
  name                = "log-${local.stack}"
  location            = azurerm_resource_group.hello_app.location
  resource_group_name = azurerm_resource_group.hello_app.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.default_tags
}

resource "azurerm_container_app_environment" "hello_app" {
  name                       = "cae-${local.stack}"
  location                   = azurerm_resource_group.hello_app.location
  resource_group_name        = azurerm_resource_group.hello_app.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.hello_app.id
  tags                       = local.default_tags
}

resource "azurerm_container_app" "hello_app" {
  name                         = "ca-${local.stack}"
  container_app_environment_id = azurerm_container_app_environment.hello_app.id
  resource_group_name          = azurerm_resource_group.hello_app.name
  revision_mode                = "Single"

  ingress {
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 8080
    traffic_weight {
      percentage = 100
    }
  }

  template {
    container {
      name   = "ctnr-${local.stack}"
      image  = local.image_repo
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  tags = local.default_tags
}
