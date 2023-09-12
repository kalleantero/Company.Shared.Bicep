param tags object
param location string
param keyVaultSku string = 'premium'
param resourceName string

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: resourceName
  location: location
  tags: tags
  properties: {
    sku: {
      family: 'A'
      name: keyVaultSku
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: false // Using Access Policies model
    enabledForDeployment: true // VMs can retrieve certificates
    enabledForTemplateDeployment: true // ARM can retrieve values
    enablePurgeProtection: true // Not allowing to purge key vault or its objects after deletion
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
    createMode: 'default' // Creating or updating the key vault (not recovering)
  }
}
