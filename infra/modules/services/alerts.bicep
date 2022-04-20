// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create an alert.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param synapsePipelineFailedAlertName string
param synapseScope string
param iothubFailedAlertName string
param iothubScope string
param eventhubnamespaceFailedAlertName string
param eventhubnamespaceScope string
param streamanalyticsFailedAlertName string
param streamanalyticsScope string
param dataEmailActionGroup string
param dataProductTeamEmail string
param enableStreamAnalytics bool
// Variables

// Resources
resource actiongroup 'Microsoft.Insights/actionGroups@2021-09-01' = {
  name: dataEmailActionGroup
  location: 'global'
  tags: tags
  properties: {
    groupShortName: 'emailgroup'
    emailReceivers: [
      {
        emailAddress: dataProductTeamEmail
        name: 'emailaction'
        useCommonAlertSchema: true
      }
    ]
    enabled: true
  }
}

resource synapsePipelineFailedAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: synapsePipelineFailedAlertName
  location: 'global'
  tags: tags
  properties: {
    actions: [
      {
        actionGroupId: actiongroup.id
      }
    ]
    autoMitigate: false
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          threshold: 1
          name: 'Metric1'
          metricNamespace: 'Microsoft.Synapse/workspaces'
          metricName: 'IntegrationPipelineRunsEnded'
          operator: 'GreaterThanOrEqual'
          timeAggregation: 'Total'
          criterionType: 'StaticThresholdCriterion'
          dimensions: [
            {
              name: 'Result'
              operator: 'Include'
              values: [
                'Failed'
              ]
            }
          ]
        }
      ]
    }
    description: 'Synapse pipeline failed'
    enabled: true
    evaluationFrequency: 'PT1M'
    scopes: [
      synapseScope
    ]
    severity: 1
    targetResourceRegion: location
    targetResourceType: 'Microsoft.Synapse/workspaces'
    windowSize: 'PT5M'
  }
}

resource iothubFailedAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: iothubFailedAlertName
  location: 'global'
  tags: tags
  properties: {
    actions: [
      {
        actionGroupId: actiongroup.id
      }
    ]
    autoMitigate: false
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          threshold: 1
          name: 'Metric1'
          metricNamespace: 'Microsoft.Devices/IotHubs'
          metricName: 'c2d.methods.failure'
          operator: 'GreaterThanOrEqual'
          timeAggregation: 'Total'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    description: 'Direct method call failed'
    enabled: true
    evaluationFrequency: 'PT1M'
    scopes: [
      iothubScope
    ]
    severity: 1
    targetResourceRegion: location
    targetResourceType: 'Microsoft.Devices/IotHubs'
    windowSize: 'PT5M'
  }
}

resource eventhubnamespaceFailedAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: eventhubnamespaceFailedAlertName
  location: 'global'
  tags: tags
  properties: {
    actions: [
      {
        actionGroupId: actiongroup.id
      }
    ]
    autoMitigate: false
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          threshold: 1
          name: 'Metric1'
          metricNamespace: 'Microsoft.EventHub/namespaces'
          metricName: 'ServerErrors'
          operator: 'GreaterThanOrEqual'
          timeAggregation: 'Total'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    description: 'Number of unprocessed requests because of error'
    enabled: true
    evaluationFrequency: 'PT1M'
    scopes: [
      eventhubnamespaceScope
    ]
    severity: 1
    targetResourceRegion: location
    targetResourceType: 'Microsoft.EventHub/namespaces'
    windowSize: 'PT5M'
  }
}

resource streamanalyticsFailedAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = if (enableStreamAnalytics) {
  name: streamanalyticsFailedAlertName
  location: 'global'
  tags: tags
  properties: {
    actions: [
      {
        actionGroupId: actiongroup.id
      }
    ]
    autoMitigate: false
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          threshold: 1
          name: 'Metric1'
          metricNamespace: 'Microsoft.StreamAnalytics/streamingjobs'
          metricName: 'Errors'
          operator: 'GreaterThanOrEqual'
          timeAggregation: 'Total'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    description: 'Number of query processing errors'
    enabled: true
    evaluationFrequency: 'PT1M'
    scopes: [
      streamanalyticsScope
    ]
    severity: 1
    targetResourceRegion: location
    targetResourceType: 'Microsoft.StreamAnalytics/streamingjobs'
    windowSize: 'PT5M'
  }
}

// Outputs
