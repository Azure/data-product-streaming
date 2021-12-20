// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

targetScope = 'resourceGroup'

// General parameters
@description('Specifies the location for all resources.')
param location string
@allowed([
  'dev'
  'tst'
  'prd'
])
@description('Specifies the environment of the deployment.')
param environment string
@minLength(2)
@maxLength(10)
@description('Specifies the prefix for all resources created in this deployment.')
param prefix string
@description('Specifies the tags that you want to apply to all resources.')
param tags object = {}

// Resource parameters
@secure()
@description('Specifies the administrator password of the sql servers.')
param administratorPassword string
@description('Specifies the resource ID of the default storage account file system for synapse.')
param synapseDefaultStorageAccountFileSystemId string
@description('Specifies whether an Azure SQL Pool should be deployed inside your Synapse workspace as part of the template. If you selected dataFactory as processingService, leave this value as is.')
param enableSqlPool bool = false
@description('Specifies whether an Azure Data Explorer Pool should be deployed inside your Synapse workspace as part of the template. If you selected dataFactory as processingService, leave this value as is.')
param enableDataExplorerPool bool = false
@description('Specifies whether Azure SQL Server should be deployed as part of the template.')
param enableSqlServer bool = false
@description('Specifies whether Azure Cosmos DB should be deployed as part of the template.')
param enableCosmos bool = false
@description('Specifies whether Azure Stream Analytics Cluster and Job should be deployed as part of the template.')
param enableStreamAnalytics bool = false
@description('Specifies the resource ID of the default storage account  file system for stream analytics.')
param streamanalyticsDefaultStorageAccountFileSystemId string = ''
@description('Specifies the resource ID of the central purview instance.')
param purviewId string = ''
@description('Specifies whether role assignments should be enabled.')
param enableRoleAssignments bool = false

// Network parameters
@description('Specifies the resource ID of the subnet to which all services will connect.')
param subnetId string

// Private DNS Zone parameters
@description('Specifies the resource ID of the private DNS zone for KeyVault.')
param privateDnsZoneIdKeyVault string = ''
@description('Specifies the resource ID of the private DNS zone for Synapse Dev.')
param privateDnsZoneIdSynapseDev string = ''
@description('Specifies the resource ID of the private DNS zone for Synapse Sql.')
param privateDnsZoneIdSynapseSql string = ''
@description('Specifies the resource ID of the private DNS zone for EventHub Namespaces.')
param privateDnsZoneIdEventhubNamespace string = ''
@description('Specifies the resource ID of the private DNS zone for Cosmos Sql.')
param privateDnsZoneIdCosmosdbSql string = ''
@description('Specifies the resource ID of the private DNS zone for Sql Server.')
param privateDnsZoneIdSqlServer string = ''
@description('Specifies the resource ID of the private DNS zone for IoT Hub.')
param privateDnsZoneIdIothub string = ''

// Variables
var name = toLower('${prefix}-${environment}')
var tagsDefault = {
  Owner: 'Data Management and Analytics Scenario'
  Project: 'Data Management and Analytics Scenario'
  Environment: environment
  Toolkit: 'bicep'
  Name: name
}
var tagsJoined = union(tagsDefault, tags)
var administratorUsername = 'SqlServerMainUser'
var synapseDefaultStorageAccountSubscriptionId = length(split(synapseDefaultStorageAccountFileSystemId, '/')) >= 13 ? split(synapseDefaultStorageAccountFileSystemId, '/')[2] : subscription().subscriptionId
var synapseDefaultStorageAccountResourceGroupName = length(split(synapseDefaultStorageAccountFileSystemId, '/')) >= 13 ? split(synapseDefaultStorageAccountFileSystemId, '/')[4] : resourceGroup().name
var streamanalyticsDefaultStorageAccountSubscriptionId = length(split(streamanalyticsDefaultStorageAccountFileSystemId, '/')) >= 13 ? split(streamanalyticsDefaultStorageAccountFileSystemId, '/')[2] : subscription().subscriptionId
var streamanalyticsDefaultStorageAccountResourceGroupName = length(split(streamanalyticsDefaultStorageAccountFileSystemId, '/')) >= 13 ? split(streamanalyticsDefaultStorageAccountFileSystemId, '/')[4] : resourceGroup().name
var streamanalyticsDefaultStorageAccountName = length(split(streamanalyticsDefaultStorageAccountFileSystemId, '/')) >= 13 ? split(streamanalyticsDefaultStorageAccountFileSystemId, '/')[8] : 'incorrectSegmentLength'
var keyVault001Name = '${name}-vault001'
var synapse001Name = '${name}-synapse001'
var cosmosdb001Name = '${name}-cosmos001'
var sql001Name = '${name}-sqlserver001'
var iothub001Name = '${name}-iothub001'
var eventhubNamespace001Name = '${name}-eventhub001'
var streamanalytics001Name = '${name}-streamanalytics001'
var streamanalyticscluster001Name = '${name}-streamanalyticscluster001'

// Resources
module keyVault001 'modules/services/keyvault.bicep' = {
  name: 'keyVault001'
  scope: resourceGroup()
  params: {
    location: location
    keyvaultName: keyVault001Name
    tags: tagsJoined
    subnetId: subnetId
    privateDnsZoneIdKeyVault: privateDnsZoneIdKeyVault
  }
}

module synapse001 'modules/services/synapse.bicep' = {
  name: 'synapse001'
  scope: resourceGroup()
  params: {
    location: location
    synapseName: synapse001Name
    tags: tagsJoined
    subnetId: subnetId
    administratorUsername: administratorUsername
    administratorPassword: administratorPassword
    synapseSqlAdminGroupName: ''
    synapseSqlAdminGroupObjectID: ''
    privateDnsZoneIdSynapseDev: privateDnsZoneIdSynapseDev
    privateDnsZoneIdSynapseSql: privateDnsZoneIdSynapseSql
    purviewId: purviewId
    enableDataExplorerPool: enableDataExplorerPool
    enableSqlPool: enableSqlPool
    synapseComputeSubnetId: ''
    synapseDefaultStorageAccountFileSystemId: synapseDefaultStorageAccountFileSystemId
  }
}

module synapse001RoleAssignmentStorage 'modules/auxiliary/synapseRoleAssignmentStorage.bicep' = if (enableRoleAssignments) {
  name: 'synapse001RoleAssignmentStorage'
  scope: resourceGroup(synapseDefaultStorageAccountSubscriptionId, synapseDefaultStorageAccountResourceGroupName)
  params: {
    storageAccountFileSystemId: synapseDefaultStorageAccountFileSystemId
    synapseId: synapse001.outputs.synapseId
  }
}

module cosmosdb001 'modules/services/cosmosdb.bicep' = if(enableCosmos) {
  name: 'cosmos001'
  scope: resourceGroup()
  params: {
    location: location
    cosmosdbName: cosmosdb001Name
    tags: tagsJoined
    subnetId: subnetId
    privateDnsZoneIdCosmosdbSql: privateDnsZoneIdCosmosdbSql
  }
}

module sql001 'modules/services/sql.bicep' = if(enableSqlServer) {
  name: 'sql001'
  scope: resourceGroup()
  params: {
    location: location
    sqlserverName: sql001Name
    tags: tagsJoined
    subnetId: subnetId
    administratorUsername: administratorUsername
    administratorPassword: administratorPassword
    privateDnsZoneIdSqlServer: privateDnsZoneIdSqlServer
    sqlserverAdminGroupName: ''
    sqlserverAdminGroupObjectID: ''
  }
}

module iothub001 'modules/services/iothub.bicep' = {
  name: 'iothub001'
  scope: resourceGroup()
  params: {
    location: location
    iothubName: iothub001Name
    tags: tagsJoined
    subnetId: subnetId
    iothubSkuName: 'S1'
    iothubSkuCapacity: 1
    privateDnsZoneIdEventhubNamespace: privateDnsZoneIdEventhubNamespace
    privateDnsZoneIdIothub: privateDnsZoneIdIothub
  }
}

module eventhubNamespace001 'modules/services/eventhubnamespace.bicep' = {
  name: 'eventhubNamespace001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    subnetId: subnetId
    eventhubnamespaceName: eventhubNamespace001Name
    privateDnsZoneIdEventhubNamespace: privateDnsZoneIdEventhubNamespace
    eventhubnamespaceMinThroughput: 1
    eventhubnamespaceMaxThroughput: 1
  }
}

module streamanalytics001 'modules/services/streamanalytics.bicep' = if(enableStreamAnalytics) {
  name: 'streamanalytics001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    eventhubNamespaceId: eventhubNamespace001.outputs.eventhubNamespaceId
    sqlServerId: enableSqlServer ? sql001.outputs.sqlserverId : ''
    storageAccountId: resourceId(streamanalyticsDefaultStorageAccountSubscriptionId, streamanalyticsDefaultStorageAccountResourceGroupName, 'Microsoft.Storage/storageAccounts', streamanalyticsDefaultStorageAccountName)
    streamanalyticsclusterName: streamanalyticscluster001Name
    streamanalyticsclusterSkuCapacity: 36
    streamanalyticsName: streamanalytics001Name
    streamanalyticsjobSkuCapacity: 1
  }
}

@batchSize(1)
module deploymentDelay 'modules/auxiliary/delay.bicep' = [for i in range(0,20): if (enableStreamAnalytics && enableRoleAssignments) {
  name: 'delay-${i}'
  dependsOn: [
    streamanalytics001
  ]
  scope: resourceGroup()
  params: {
    deploymentDelayIndex: i
  }
}]

module streamanalytics001RoleAssignmentStorage 'modules/auxiliary/streamanalyticsRoleAssignmentStorage.bicep' = if (enableStreamAnalytics && enableRoleAssignments) {
  name: 'streamanalytics001RoleAssignmentStorage'
  dependsOn: [
    deploymentDelay
  ]
  scope: resourceGroup(streamanalyticsDefaultStorageAccountSubscriptionId, streamanalyticsDefaultStorageAccountResourceGroupName)
  params: {
    storageAccountFileSystemId: streamanalyticsDefaultStorageAccountFileSystemId
    streamanalyticsjobId: enableStreamAnalytics ? streamanalytics001.outputs.streamanalyticsjob001Id : ''
  }
}

// Outputs
