@description('The name of the Log Analytics Workspace to deploy')
param logAnalyticsWorkspaceName string

@description('The location to deploy the workspace to.')
param location string

@description('The SKU to use for the Log Analytics workspace')
param logAnalyticsWorkspaceSKU string

@description('Enable public access on workspace')
param enablePublicAccessOnWorkspace string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: {
   sku: {
    name: logAnalyticsWorkspaceSKU
   }
   publicNetworkAccessForIngestion: enablePublicAccessOnWorkspace
   publicNetworkAccessForQuery: enablePublicAccessOnWorkspace
  }
}

output logAnalyticsWorkspaceId string = logAnalyticsWorkspace.id
