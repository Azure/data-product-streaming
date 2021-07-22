// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// The module contains a template to create a role assignment of the Synase MSI to a file system.
targetScope = 'resourceGroup'

// Parameters
param storageAccountFileSystemId string
param streamanalyticsjobId string

// Variables
var storageAccountFileSystemName = length(split(storageAccountFileSystemId, '/')) >= 13 ? last(split(storageAccountFileSystemId, '/')) : 'incorrectSegmentLength'
var storageAccountName = length(split(storageAccountFileSystemId, '/')) >= 13 ? split(storageAccountFileSystemId, '/')[8] : 'incorrectSegmentLength'
var streamanalyticsjobSubscriptionId = length(split(streamanalyticsjobId, '/')) >= 9 ? split(streamanalyticsjobId, '/')[2] : subscription().subscriptionId
var streamanalyticsjobResourceGroupName = length(split(streamanalyticsjobId, '/')) >= 9 ? split(streamanalyticsjobId, '/')[4] : resourceGroup().name
var streamanalyticsjobName = length(split(streamanalyticsjobId, '/')) >= 9 ? last(split(streamanalyticsjobId, '/')) : 'incorrectSegmentLength'

// Resources
resource storageAccountFileSystem 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' existing = {
  name: '${storageAccountName}/default/${storageAccountFileSystemName}'
}

resource streamanalyticsjob 'Microsoft.StreamAnalytics/streamingjobs@2017-04-01-preview' existing = {
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
