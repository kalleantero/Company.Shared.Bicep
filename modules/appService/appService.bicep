param environment string
param appInsightsInstrumentationKey string
param tags object
param location string
param appSettings object = {}
param serverFarmId string
param productName string
param kind string = 'api,linux'
param linuxFxVersion string = 'DOTNETCORE|6.0'
param startUpCommand string = ''

var prefixes = loadJsonContent('../../assets/prefixes.json')

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: '${prefixes.webApp}-${productName}-${environment}'
  kind: kind
  location: location
  tags: tags
  properties: {
    enabled: true
    serverFarmId: serverFarmId
    reserved: true
    isXenon: false
    hyperV: false
    siteConfig: {
      numberOfWorkers: 1
      linuxFxVersion: linuxFxVersion
      acrUseManagedIdentityCreds: false
      alwaysOn: true
      appCommandLine: startUpCommand
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 0
      ftpsState: 'Disabled'
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    httpsOnly: true
    redundancyMode: 'None'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'

  }
  identity: {
    type: 'SystemAssigned'
  }
}

module appSettingModule 'appSettings.bicep' = {
  name: 'app-settings'
  params: {
    webAppName: appService.name
    currentAppSettings: list('${appService.id}/config/appsettings', '2021-02-01').properties
    appSettingType: 'appsettings'
    appSettings: union(appSettings, {
        APPINSIGHTS_INSTRUMENTATIONKEY: appInsightsInstrumentationKey
        ASPNETCORE_ENVIRONMENT: environment
        WEBSITE_LOAD_CERTIFICATES: '*'
      })
  }
}

output defaultHostName string = appService.properties.defaultHostName
output appServiceName string = appService.name
output appServiceId string = appService.id
output possibleOutboundIpAddresses string = appService.properties.possibleOutboundIpAddresses
