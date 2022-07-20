@description('The location to deploy our Function App resources to.')
param location string

@description('The name of the storage account to deploy with the Function App')
param storageAccountName string

@description('The SKU to use for the Storage Account')
param storageAccountSKU string

@description('The name given to the Function App')
param functionAppName string

@description('The App Plan Id to deploy the Function to.')
param appServicePlanId string

@description('The App Insights Instrumentation Key to connect this Function to')
param appInsightsInstrumentationKey string

@description('The name of the container that this Function will use')
param containerName string

@description('The database that this Function will use')
param databaseName string

@description('The Cosmos DB endpoint that this Function will use')
param cosmosDbEndpoint string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSKU
  }
  kind: 'StorageV2'
}

resource functionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value}'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsightsInstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: 'InstrumentationKey=${appInsightsInstrumentationKey}'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'ContainerName'
          value: containerName
        }
        {
          name: 'DatabaseName'
          value: databaseName
        }
        {
          name: 'CosmosDbEndpoint'
          value: cosmosDbEndpoint
        }
      ]
    }
  }
}

output functionAppPrincipalId string = functionApp.identity.principalId
