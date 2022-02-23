// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create an alert.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param synapsePipelineFailedAlertName string
param synapseScope string
param dataEmailActionGroup string
param dataProductTeamEmail string


// Variables

// Resources
resource actiongroup 'Microsoft.Insights/actionGroups@2021-09-01' =  {
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
            threshold : 1
            name : 'Metric1'
            metricNamespace: 'Microsoft.Synapse/workspaces'
            metricName: 'IntegrationPipelineRunsEnded'
            operator: 'GreaterThan'
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

// Outputs
