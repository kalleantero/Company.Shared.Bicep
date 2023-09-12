param tags object
param location string = resourceGroup().location
param productName string
param environment string

@allowed([
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P1v2'
  'P2v2'
  'P3v2'
  'P1v3'
  'P2v2'
  'P2v3'
  'Y1'
])
param planName string = 'B1'

@description('SKU Tier for app service plan')
@allowed([
  'Basic'
  'Standard'
  'Premium'
  'Dynamic'
])
param planTier string = 'Basic'

@minValue(1)
@maxValue(10)
@description('App Service Plan\'s instance count')
param capacity int = 1

var prefixes = loadJsonContent('../../assets/prefixes.json')

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: '${prefixes.appServicePlan}-${productName}-${environment}'
  kind: 'linux'
  location: location
  tags: tags
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
  sku: {
    name: planName
    tier: planTier
    capacity: capacity
  }
}

output serverFarmId string = appServicePlan.id
