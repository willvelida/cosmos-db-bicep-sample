@description('The name of the App Service Plan')
param appServicePlanName string

@description('The location to deploy the App Service Plan to')
param location string

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location 
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
  properties: {}
}

output appServicePlanId string = appServicePlan.id
