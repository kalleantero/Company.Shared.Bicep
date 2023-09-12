param location string
param tags object
param productName string
param environment string

var prefixes = loadJsonContent('../../assets/prefixes.json')

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: '${prefixes.logAnalyticsWorkspace}-${productName}-${environment}'
  location: location
  tags: tags
  properties: any({
    retentionInDays: 30
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
  })
}

output logAnalyticsWorkspaceId string = logAnalyticsWorkspace.id
