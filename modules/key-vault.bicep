param keyVaultName string
param location string
param tenantId string
param clientId string

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenantId
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: reference(clientId, '2022-01-01', 'Full').principalId
        permissions: {
          secrets: [
            'get'
            'list'
            'set'
          ]
        }
      }
    ]
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enableRbacAuthorization: false
  }
}

output keyVaultUri string = keyVault.properties.vaultUri 
