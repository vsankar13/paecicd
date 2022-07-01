terraform {
  backend "azurerm" {
    resource_group_name  = "ecstfstates"
    storage_account_name = "ecstfrao"
    container_name       = "tfstatedevops"
    key                  = "terraformgithubexample.tfstate"
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
  skip_provider_registration = true
}

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "ecstool" {
  name     = "ecstool"
  location = "eastus2"
}

#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "ecstool-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.ecstool.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.ecstool.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}

# Create Resource group
resource "azurerm_resource_group" "rg" {
  name     = "ecstoolResourceGroup"
  location = "eastus"
}