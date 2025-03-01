# Definir variáveis
$resourceGroup = "MeuProjetoEngDados-RG"
$location = "East US"
$storageAccount = "meuprojetoengdados"
$databricksWorkspace = "meuprojeto-databricks"
$dataFactory = "meuprojeto-adf"

# Login na conta Azure (caso não esteja autenticado)
Write-Host "Autenticando no Azure..."
az login

# Criar grupo de recursos
Write-Host "Criando grupo de recursos: $resourceGroup"
az group create --name $resourceGroup --location $location

# Criar conta de armazenamento ADLS Gen2
Write-Host "Criando Azure Data Lake Storage Gen2..."
az storage account create `
    --name $storageAccount `
    --resource-group $resourceGroup `
    --location $location `
    --sku Standard_LRS `
    --kind StorageV2 `
    --hns true  # Habilita Hierarchical Namespace (Necessário para ADLS Gen2)

# Criar container no Data Lake
Write-Host "Criando container 'raw' no Data Lake..."
az storage container create `
    --name raw `
    --account-name $storageAccount

# Criar workspace do Databricks
Write-Host "Criando workspace do Azure Databricks..."
az databricks workspace create `
    --resource-group $resourceGroup `
    --name $databricksWorkspace `
    --location $location `
    --sku standard

# Criar Azure Data Factory
Write-Host "Criando serviço do Azure Data Factory..."
az datafactory create `
    --resource-group $resourceGroup `
    --name $dataFactory `
    --location $location

Write-Host "Configuração concluída!"
