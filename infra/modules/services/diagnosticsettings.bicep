// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to setup diagnostic settings.
targetScope = 'resourceGroup'

// Parameters
param logAnalyticsName string
param synapseName string
param cosmosdbName string
param iothubName string
param sqlserverName string
param eventhubnamespaceName string
param streamanalyticsName string
param synapseSqlPools array
param synapseSparkPools array
param enableCosmos bool
param enableStreamAnalytics bool
param database001Name string

//variables
var synapseSqlPoolsCount = length(synapseSqlPools)
var synapseSparkPoolCount = length(synapseSparkPools)

//Resources
resource synapseworkspace 'Microsoft.Synapse/workspaces@2021-06-01' existing = {
  name: synapseName
}

resource synapsesqlpool 'Microsoft.Synapse/workspaces/sqlPools@2021-06-01' existing = [for sqlPool in synapseSqlPools: {
  parent: synapseworkspace
  name: sqlPool
}]

resource synapsebigdatapool 'Microsoft.Synapse/workspaces/bigDataPools@2021-06-01' existing = [for sparkPool in synapseSparkPools: {
  parent: synapseworkspace
  name: sparkPool
}]

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' existing = {
  name: logAnalyticsName
}

resource cosmosdb 'Microsoft.DocumentDB/databaseAccounts@2021-03-15' existing = {
  name: cosmosdbName
}

resource iothub 'Microsoft.Devices/IotHubs@2021-03-31' existing = {
  name: iothubName
}

resource sqlserver 'Microsoft.Sql/servers@2020-11-01-preview' existing = {
  name: sqlserverName
}

resource sqlserverDatabase001 'Microsoft.Sql/servers/databases@2020-11-01-preview' existing = {
  parent: sqlserver
  name: database001Name
}

resource eventhubNamespace 'Microsoft.EventHub/namespaces@2021-06-01-preview' existing = {
  name: eventhubnamespaceName
}

resource streamanalyticsjob001 'Microsoft.StreamAnalytics/streamingjobs@2020-03-01' existing = {
  name: streamanalyticsName
}

resource diagnosticSetting001 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: synapseworkspace
  name: 'diagnostic-${synapseworkspace.name}'
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'SynapseRbacOperations'
        enabled: true
      }
      {
        category: 'GatewayApiRequests'
        enabled: true
      }
      {
        category: 'BuiltinSqlReqsEnded'
        enabled: true
      }
      {
        category: 'IntegrationPipelineRuns'
        enabled: true
      }
      {
        category: 'IntegrationActivityRuns'
        enabled: true
      }
      {
        category: 'IntegrationTriggerRuns'
        enabled: true
      }
    ]
  }
}

resource diagnosticSetting002 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = [for i in range(0, synapseSqlPoolsCount): {
  scope: synapsesqlpool[i]
  name: 'diagnostic-${synapseworkspace.name}-${synapsesqlpool[i].name}'
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'SqlRequests'
        enabled: true
      }
      {
        category: 'RequestSteps'
        enabled: true
      }
      {
        category: 'ExecRequests'
        enabled: true
      }
      {
        category: 'DmsWorkers'
        enabled: true
      }
      {
        category: 'Waits'
        enabled: true
      }
    ]
  }
}]

resource diagnosticSetting003 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = [for i in range(0, synapseSparkPoolCount): {
  scope: synapsebigdatapool[i]
  name: 'diagnostic-${synapseworkspace.name}-${synapsebigdatapool[i].name}'
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'BigDataPoolAppsEnded'
        enabled: true
      }
    ]
  }
}]

resource diagnosticSetting004 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (enableCosmos) {
  scope: cosmosdb
  name: 'diagnostic-${cosmosdb.name}'
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'DataPlaneRequests'
        enabled: true
      }
      {
        category: 'QueryRuntimeStatistics'
        enabled: true
      }
      {
        category: 'PartitionKeyStatistics'
        enabled: true
      }
      {
        category: 'PartitionKeyRUConsumption'
        enabled: true
      }
      {
        category: 'ControlPlaneRequests'
        enabled: true
      }
    ]
  }
}

resource diagnosticSetting005 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: iothub
  name: 'diagnostic-${iothub.name}'
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'Connections'
        enabled: true
      }
      {
        category: 'DeviceTelemetry'
        enabled: true
      }
      {
        category: 'C2DCommands'
        enabled: true
      }
      {
        category: 'DeviceIdentityOperations'
        enabled: true
      }
      {
        category: 'FileUploadOperations'
        enabled: true
      }
      {
        category: 'Routes'
        enabled: true
      }
      {
        category: 'D2CTwinOperations'
        enabled: true
      }
      {
        category: 'C2DTwinOperations'
        enabled: true
      }
      {
        category: 'TwinQueries'
        enabled: true
      }
      {
        category: 'JobsOperations'
        enabled: true
      }
      {
        category: 'DirectMethods'
        enabled: true
      }
      {
        category: 'DistributedTracing'
        enabled: true
      }
      {
        category: 'Configurations'
        enabled: true
      }
      {
        category: 'DeviceStreams'
        enabled: true
      }
    ]
  }
}

resource diagnosticSetting006 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: eventhubNamespace
  name: 'diagnostic-${eventhubNamespace.name}'
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'ArchiveLogs'
        enabled: true
      }
      {
        category: 'OperationalLogs'
        enabled: true
      }
      {
        category: 'AutoScaleLogs'
        enabled: true
      }
      {
        category: 'KafkaCoordinatorLogs'
        enabled: true
      }
      {
        category: 'KafkaUserErrorLogs'
        enabled: true
      }
      {
        category: 'EventHubVNetConnectionEvent'
        enabled: true
      }
      {
        category: 'CustomerManagedKeyUserLogs'
        enabled: true
      }
      {
        category: 'RuntimeAuditLogs'
        enabled: true
      }
      {
        category: 'ApplicationMetricsLogs'
        enabled: true
      }
    ]
  }
}

resource diagnosticSetting007 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (enableStreamAnalytics) {
  scope: streamanalyticsjob001
  name: 'diagnostic-${streamanalyticsjob001.name}'
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'Execution'
        enabled: true
      }
      {
        category: 'Authoring'
        enabled: true
      }
    ]
  }
}

//Outputs
