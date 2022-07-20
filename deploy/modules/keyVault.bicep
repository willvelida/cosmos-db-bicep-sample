@description('The name of the Key Vault that we will deploy.')
param keyVaultName string

@description('The location to deploy the Key Vault to')
param location string

@description('The Cosmos DB account that will be used for secrets')
param cosmosDbAccountName string

resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2022-05-15' existing = {
  name: cosmosDbAccountName
}

resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
    enabledForDeployment: true
    accessPolicies: [
      
    ]
  }
}

// Store our Cosmos DB secrets into our Key Vault
resource cosmosDbConnectionStringSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  name: 'CosmosDbConnectionString'
  parent: keyVault 
  properties: {
    value: cosmosDbAccount.listConnectionStrings().connectionStrings[0].connectionString
  }
}

resource cosmosDbPrimaryKeySecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  name: 'CosmosDbPrimaryKey'
  parent: keyVault
  properties: {
    value: cosmosDbAccount.listKeys().primaryMasterKey
  }
}

resource cosmosDbPrimaryReadKeySecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  name: 'CosmosDbPrimaryReadKey'
  parent: keyVault
  properties: {
    value: cosmosDbAccount.listKeys().primaryReadonlyMasterKey
  }
}

resource cosmosDbSecondaryKeySecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  name: 'CosmosDbSecondaryKey'
  parent: keyVault
  properties: {
    value: cosmosDbAccount.listKeys().secondaryMasterKey
  }
}

resource cosmosDbSecondaryReadKeySecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  name: 'CosmosDbSecondaryReadKey'
  parent: keyVault
  properties: {
    value: cosmosDbAccount.listKeys().secondaryReadonlyMasterKey
  }
}
