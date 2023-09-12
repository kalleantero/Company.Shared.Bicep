@description('Name of the web app')
param webAppName string

@description('App setting type')
@allowed([
  'appsettings'
  'connectionstrings'
])
param appSettingType string

@description('Dynamic app settings from parameter.json')
param appSettings object

@description('Current app settings')
param currentAppSettings object

@description('Rewrites app settings to app service, by joining existing app settings and given dynamic')
resource siteconfig 'Microsoft.Web/sites/config@2022-03-01' = {
  name: '${webAppName}/${appSettingType}'
  properties: union(currentAppSettings, appSettings)
}
