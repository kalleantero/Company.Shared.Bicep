
param keyVaultResourceName string
param principalId string
param keyVaultPermissions object
@allowed([
  'add'
  'remove'
  'replace'
])
param policyAction string

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: keyVaultResourceName
  resource keyVaultPolicies 'accessPolicies' = {
    name: policyAction
    properties: {    
      accessPolicies: [
        {
          objectId: principalId
          permissions: keyVaultPermissions
          tenantId: subscription().tenantId
        }
      ]
    }
  }  
}
