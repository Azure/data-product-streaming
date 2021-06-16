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

// Resource parameters
@secure()
@description('Specifies the administrator password of the sql servers.')
param administratorPassword string
@description('Specifies the resource ID of the default storage account file system for synapse.')
param synapseDefaultStorageAccountFileSystemId string
@description('Specifies the resource ID of the default storage account for strea analytics.')
param streamanalyticsDefaultStorageAccountFileSystemId string
@description('Specifies the resource ID of the central purview instance.')
param purviewId string
@description('Specifies whether role assignments should be enabled.')
param enableRoleAssignments bool

// Network parameters
@description('Specifies the resource ID of the subnet to which all services will connect.')
param subnetId string

// Private DNS Zone parameters
@description('Specifies the resource ID of the private DNS zone for KeyVault.')
param privateDnsZoneIdKeyVault string
@description('Specifies the resource ID of the private DNS zone for Synapse Dev.')
param privateDnsZoneIdSynapseDev string
@description('Specifies the resource ID of the private DNS zone for Synapse Sql.')
param privateDnsZoneIdSynapseSql string
@description('Specifies the resource ID of the private DNS zone for EventHub Namespaces.')
param privateDnsZoneIdEventhubNamespace string
@description('Specifies the resource ID of the private DNS zone for Cosmos Sql.')
param privateDnsZoneIdCosmosdbSql string
@description('Specifies the resource ID of the private DNS zone for Sql Server.')
param privateDnsZoneIdSqlServer string
@description('Specifies the resource ID of the private DNS zone for IoT Hub.')
param privateDnsZoneIdIothub string

// Variables
var name = toLower('${prefix}-${environment}')
var tags = {
  Owner: 'Enterprise Scale Analytics'
  Project: 'Enterprise Scale Analytics'
  Environment: environment
  Toolkit: 'bicep'
  Name: name
}
var synapseDefaultStorageAccountSubscriptionId = split(synapseDefaultStorageAccountFileSystemId, '/')[2]
var synapseDefaultStorageAccountResourceGroupName = split(synapseDefaultStorageAccountFileSystemId, '/')[4]
var streamanalyticsDefaultStorageAccountSubscriptionId = split(streamanalyticsDefaultStorageAccountFileSystemId, '/')[2]
var streamanalyticsDefaultStorageAccountResourceGroupName = split(streamanalyticsDefaultStorageAccountFileSystemId, '/')[4]
var streamanalyticsDefaultStorageAccountName = split(streamanalyticsDefaultStorageAccountFileSystemId, '/')[8]

// Resources
module keyvault001 'modules/services/keyvault.bicep' = {
  name: 'keyvault001'
  scope: resourceGroup()
  params: {
    location: location
    keyvaultName: '${name}-vault001'
    tags: tags
    subnetId: subnetId
    privateDnsZoneIdKeyVault: privateDnsZoneIdKeyVault
  }
}

module synapse001 'modules/services/synapse.bicep' = {
  name: 'synapse001'
  scope: resourceGroup()
  params: {
    location: location
    synapseName: '${name}-synapse001'
    tags: tags
    subnetId: subnetId
    administratorPassword: administratorPassword
    synapseSqlAdminGroupName: ''
    synapseSqlAdminGroupObjectID: ''
    privateDnsZoneIdSynapseDev: privateDnsZoneIdSynapseDev
    privateDnsZoneIdSynapseSql: privateDnsZoneIdSynapseSql
    purviewId: purviewId
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

module cosmosdb001 'modules/services/cosmosdb.bicep' = {
  name: 'cosmos001'
  scope: resourceGroup()
  params: {
    location: location
    cosmosdbName: '${name}-cosmos001'
    tags: tags
    subnetId: subnetId
    privateDnsZoneIdCosmosdbSql: privateDnsZoneIdCosmosdbSql
  }
}

module sql001 'modules/services/sql.bicep' = {
  name: 'sql001'
  scope: resourceGroup()
  params: {
    location: location
    sqlserverName: '${name}-sqlserver001'
    tags: tags
    subnetId: subnetId
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
    iothubName: '${name}-iothub001'
    tags: tags
    subnetId: subnetId
    iothubSkuName: 'S1'
    iothubSkuCapacity: 1
    privateDnsZoneIdEventhubNamespace: privateDnsZoneIdEventhubNamespace
    privateDnsZoneIdIothub: privateDnsZoneIdIothub
  }
}

module eventhubNamespace001 'modules/services/eventhubnamespace.bicep' = {
  name: 'eventhubNamespaceDomain001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tags
    subnetId: subnetId
    eventhubnamespaceName: '${name}-eventhub001'
    privateDnsZoneIdEventhubNamespace: privateDnsZoneIdEventhubNamespace
    eventhubnamespaceMinThroughput: 1
    eventhubnamespaceMaxThroughput: 1
  }
}

module streamanalytics001 'modules/services/streamanalytics.bicep' = {
  name: 'streamanalytics001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tags
    eventhubNamespaceId: eventhubNamespace001.outputs.eventhubNamespaceId
    sqlServerId: sql001.outputs.sqlserverId
    storageAccountId: resourceId(streamanalyticsDefaultStorageAccountSubscriptionId, streamanalyticsDefaultStorageAccountResourceGroupName, 'Microsoft.Storage/storageAccounts', streamanalyticsDefaultStorageAccountName)
    streamanalyticsclusterName: '${name}-streamanalyticscluster001'
    streamanalyticsclusterSkuCapacity: 36
    streamanalyticsName: '${name}-streamanalytics001'
    streamanalyticsjobSkuCapacity: 1
  }
}

module streamanalytics001RoleAssignmentStorage 'modules/auxiliary/streamanalyticsRoleAssignmentStorage.bicep' = if (enableRoleAssignments) {
  name: 'streamanalytics001RoleAssignmentStorage'
  scope: resourceGroup(streamanalyticsDefaultStorageAccountSubscriptionId, streamanalyticsDefaultStorageAccountResourceGroupName)
  params: {
    storageAccountFileSystemId: streamanalyticsDefaultStorageAccountFileSystemId
    streamanalyticsjobId: streamanalytics001.outputs.streamanalyticsjob001Id
  }
}
