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

To deploy our infrastructure to Azure, this sample uses GitHub Actions to deploy our Bicep templates. The workflow contains the following steps:

To use GitHub Actions to deploy our Bicep file, we need to do some initial setup.

We first need a resource group in Azure to deploy our resources to. We can create this using the Azure CLI. Using the below command, replace the name with the name you want to use for your resource group and the location that you want to deploy your resources to:

```bash
az group create -n <resource-group-name> -l <location>
```

*Note: Replace <> with your own values.*

Once you have created your resource group, we need to generate deployment credentials. The GitHub Action that we use for our deployment needs to run under an identity. We can use the Azure CLI to create a service principal for the identity:

```bash
az ad sp create-for-rbac --name yourApp --role contributor --scopes /subscriptions/{subscription-id}/resourceGroups/exampleRG --sdk-auth
```

Replace the --name parameter with the ```name``` of your application. The scope of the service principal is limited to the resource group. The output of this command will generate a JSON object with the role assignment credentials that provide access. Copy the JSON Object output:

```json
{
    "clientId": "<GUID>",
    "clientSecret": "<GUID>",
    "subscriptionId": "<GUID>",
    "tenantId": "<GUID>",
}
```

Once this is done, we can set up the following secrets to our GitHub repo. We can do this in our repository by navigating to **Settings** > **Secrets**.

| Secret | Values |
| ------ | ------ |
| ```AZURE_CREDENTIALS``` | The entire JSON output from the service principal creation step |
| ```AZURE_RG``` | The name of your resource group |

Once you've set up the secrets, you can run the [workflow file](https://github.com/willvelida/cosmos-db-bicep-sample/blob/main/.github/workflows/deploy.yml).


### Option 2: Deploy via 'Deploy to Azure' Button

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fwillvelida%2Fcosmos-db-bicep-sample%2Fmain%2Fdeploy%2Fazuredeploy.json)

### Option 3: Deploy via CLI