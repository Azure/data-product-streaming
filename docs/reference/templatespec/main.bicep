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
@description('Specifies the resource ID of the default storage account  file system for stream analytics.')
param streamanalyticsDefaultStorageAccountFileSystemId string
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

// Template Spec parameters 
param templateSpecId string

// Variables
var name = toLower('${prefix}-${environment}')
var tagsDefault = {
  Owner: 'Enterprise Scale Analytics'
  Project: 'Enterprise Scale Analytics'
  Environment: environment
  Toolkit: 'bicep'
  Name: name
}
var tagsJoined = union(tagsDefault, tags)

// Resources
resource templatespec 'Microsoft.Resources/deployments@2021-04-01' = {
  name: 'templatespec-${name}'
  location: location
  tags: tagsJoined
  properties: {
    mode: 'Incremental'
    templateLink: {
      id: templateSpecId
    }
    parameters: {
      location: {
        value: location
      }
      environment: {
        value: environment
      }
      prefix: {
        value: prefix
      }
      tags: {
        value: tagsJoined
      }
      administratorPassword: {
        value: administratorPassword
      }
      synapseDefaultStorageAccountFileSystemId: {
        value: synapseDefaultStorageAccountFileSystemId
      }
      streamanalyticsDefaultStorageAccountFileSystemId: {
        value: streamanalyticsDefaultStorageAccountFileSystemId
      }
      subnetId: {
        value: subnetId
      }
      purviewId: {
        value: purviewId
      }
      enableRoleAssignments: {
        value: enableRoleAssignments
      }
      privateDnsZoneIdKeyVault: {
        value: privateDnsZoneIdKeyVault
      }
      privateDnsZoneIdSynapseDev: {
        value: privateDnsZoneIdSynapseDev
      }
      privateDnsZoneIdSynapseSql: {
        value: privateDnsZoneIdSynapseSql
      }
      privateDnsZoneIdEventhubNamespace: {
        value: privateDnsZoneIdEventhubNamespace
      }
      privateDnsZoneIdCosmosdbSql: {
        value: privateDnsZoneIdCosmosdbSql
      }
      privateDnsZoneIdSqlServer: {
        value: privateDnsZoneIdSqlServer
      }
      privateDnsZoneIdIothub: {
        value: privateDnsZoneIdIothub
      }
    }
  }
}
