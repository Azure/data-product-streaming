// The module contains a template to create a role assignment of the Synase MSI to a file system.
targetScope = 'resourceGroup'

// Parameters
param storageAccountFileSystemId string
param streamanalyticsjobId string

// Variables
var storageAccountFileSystemName = last(split(storageAccountFileSystemId, '/'))
var storageAccountName = split(storageAccountFileSystemId, '/')[8]
var streamanalyticsjobSubscriptionId = split(streamanalyticsjobId, '/')[2]
var streamanalyticsjobResourceGroupName = split(streamanalyticsjobId, '/')[4]
var streamanalyticsjobName = last(split(streamanalyticsjobId, '/'))

// Resources
resource storageAccountFileSystem 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' existing = {
  name: '${storageAccountName}/default/${storageAccountFileSystemName}'
}

resource streamanalyticsjob 'Microsoft.Synapse/workspaces@2021-03-01' existing = {
  name: streamanalyticsjobName
  scope: resourceGroup(streamanalyticsjobSubscriptionId, streamanalyticsjobResourceGroupName)
}

resource synapseRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(uniqueString(storageAccountFileSystem.id, streamanalyticsjob.id))
  scope: storageAccountFileSystem
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
    principalId: streamanalyticsjob.identity.principalId
  }
}

// Outputs
