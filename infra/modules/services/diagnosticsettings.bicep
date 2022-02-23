// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to setup diagnostic settings.
targetScope = 'resourceGroup'

// Parameters
param loganalyticsName string
param synapseName string
param synapseSqlPoolName string
param synapseSparkPoolName string

//Resources
resource synapseworkspace 'Microsoft.Synapse/workspaces@2021-06-01' existing = if (processingService == 'synapse') {
  name: synapseName
}

resource synapsesqlpool 'Microsoft.Synapse/workspaces/sqlPools@2021-06-01' existing = {
  parent: synapseworkspace
  name: synapseSqlPoolName
}

resource synapsebigdatapool 'Microsoft.Synapse/workspaces/bigDataPools@2021-06-01' existing = {
  parent: synapseworkspace
  name: synapseSparkPoolName
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' existing = {
  name: loganalyticsName
}

resource diagnosticSetting1 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
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

resource diagnosticSetting2 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: synapsesqlpool
  name: 'diagnostic-${synapseworkspace.name}-${synapsesqlpool.name}'
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
}

resource diagnosticSetting3'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: synapsebigdatapool
  name: 'diagnostic-${synapseworkspace.name}-${synapsebigdatapool.name}'
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'BigDataPoolAppsEnded'
        enabled: true
      }
    ]
  }
}

//Outputs
