@description('The name of the App Service Plan')
param appServicePlanName string

@description('The location to deploy the App Service Plan to')
param location string

@description('The time that this deployment was initiated')
param deploymentTime string = utcNow('u')

var tags = {
  DeployedAt: deploymentTime
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  tags: tags
  location: location 
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
  properties: {}
}

output appServicePlanId string = appServicePlan.id
