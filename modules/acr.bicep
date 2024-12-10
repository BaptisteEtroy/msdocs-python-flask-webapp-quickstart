param name string
param location string
param acrAdminUserEnabled bool = true

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: name
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: acrAdminUserEnabled
  }
}

output loginServer string = acr.properties.loginServer
output adminUsername string = acr.name
@secure()
output adminPassword string = acr.listCredentials().passwords[0].value
