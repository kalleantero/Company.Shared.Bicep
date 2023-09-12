param location string = deployment().location

@description('Tags')
param tags object

@description('Name of this resource group to be created')
param resourceGroupName string

targetScope = 'subscription'

@description('Resource group')
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
  properties: {}
}

output resourceGroupName string = resourceGroup.name
