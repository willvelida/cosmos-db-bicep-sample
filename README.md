# Deploying Azure Cosmos DB using Bicep Lang and GitHub Actions

This sample contains all the code demonstrated during my talk at [Auckland Analytics 2022](https://analytics-friday-auckland.sessionize.com/session/342929) session on **Deploying Azure Cosmos DB using Bicep Lang and GitHub Actions**.

This sample deploys the following resources:

- Azure Cosmos DB Account.
- Log Analytics workspace.
- App Insights workspace.
- Key Vault.
- Azure Function (with App Plan and Storage Account).
- Diagnostic logs from Azure Cosmos DB sent to Log Analytics.
- Stores Cosmos DB secrets in Azure Key Vault.
- Enables Microsoft Defender for Azure Cosmos DB.
- Creates and Assigns a custom SQL Role for the deployed Azure Function to make operations on Cosmos DB.

## Deploying the sample

### Option 1: Deploy via GitHub Actions


### Option 2: Deploy via 'Deploy to Azure' Button

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fwillvelida%2Fcosmos-db-bicep-sample%2Fmain%2Fdeploy%2Fazuredeploy.json)

### Option 3: Deploy via CLI