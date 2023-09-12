param logAnalyticsWorkspaceId string
param location string
param tags object
param productName string
param environment string

var prefixes = loadJsonContent('../../assets/prefixes.json')

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${prefixes.applicationInsights}-${productName}-${environment}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspaceId
  }
  tags: tags
}

output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey
output appInsightsId string = appInsights.id
output appInsightsName string = appInsights.name
