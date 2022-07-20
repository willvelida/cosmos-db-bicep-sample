@description('The name of the App Insights workspace')
param appInsightsName string

@description('The Location to deploy the App Insights workspace to')
param location string

@description('Enable public access on the workspace')
param enablePublicAccessOnWorkspace string

@description('The Log Analytics Workspace Id. Used to connect App Insights to Log Analytics')
param logAnalyticsWorkspaceId string

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location 
  kind: 'web'
  properties: {
    Application_Type: 'web'
    publicNetworkAccessForIngestion: enablePublicAccessOnWorkspace
    publicNetworkAccessForQuery: enablePublicAccessOnWorkspace
    WorkspaceResourceId: logAnalyticsWorkspaceId
  }
}

output instrumentationKey string = appInsights.properties.InstrumentationKey
