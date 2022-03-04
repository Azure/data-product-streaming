// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create a dashboard.
targetScope = 'resourceGroup'

// Parameters
param location string
param dashboardName string
param tags object
param synapseScope string
param synapse001Name string
param cosmosdbScope string
param cosmosdb001Name string
param iothubScope string
param iothub001Name string
param sqlScope string
param sql001Name string
param eventhubnamespaceScope string
param eventhubnamespace001Name string
param streamanalyticsScope string
param streamanalytics001Name string


// Variables

// Resources
resource dashboardSynapse 'Microsoft.Portal/dashboards@2020-09-01-preview' = {
  name: '${dashboardName}-synapse'
  location: location
  tags: tags
    properties  : {
      lenses  : [
        {
              order  : 0  
              parts  : [
                {
                      position  : {
                          x  : 0  
                          y  : 0  
                          rowSpan  : 4  
                          colSpan  : 6
                    }  
                      metadata  : {
                          inputs  : [
                            {
                              name: 'options'
                              isOptional: true
                            }
                            {
                              name: 'sharedTimeRange'
                              isOptional: true
                            }
                        ]  
                          type  : 'Extension/HubsExtension/PartType/MonitorChartPart'
                          settings  : {
                              content  : {
                                options: {
                                 chart: {
                                   metrics: [
                                     {
                                       resourceMetadata: {
                                          id : synapseScope
                                       }
                                        name :  'IntegrationPipelineRunsEnded' 
                                        aggregationType : 1
                                        namespace :  'microsoft.synapse/workspaces' 
                                        metricVisualization : {
                                          displayName :  'Pipeline runs ended' 
                                          resourceDisplayName : synapse001Name
                                       }
                                     }
                                   ]
                                    title :  'Sum Pipeline runs ended for ${synapse001Name}' 
                                    titleKind : 1
                                    visualization : {
                                      chartType : 2
                                      legendVisualization : {
                                        isVisible : true
                                        position : 2
                                        hideSubtitle : false
                                     }
                                      axisVisualization : {
                                        x : {
                                          isVisible : true
                                          axisType : 2
                                       }
                                        y : {
                                          isVisible : true
                                          axisType : 1
                                       }
                                     }
                                      disablePinning : true
                                   }
                                 }
                               }
                             }
                        }
                    }
                }
                {
                  position  : {
                      x  : 6  
                      y  : 0  
                      rowSpan  : 4  
                      colSpan  : 6
                }  
                  metadata  : {
                      inputs  : [
                        {
                          name: 'options'
                          isOptional: true
                        }
                        {
                          name: ''
                          isOptional: true
                        }
                    ]  
                      type  :  'Extension/HubsExtension/PartType/MonitorChartPart'    
                      settings  : {
                          content  : {
                            options: {
                             chart: {
                               metrics: [
                                 {
                                   resourceMetadata: {
                                      id : synapseScope
                                   }
                                    name :  'IntegrationActivityRunsEnded' 
                                    aggregationType : 1
                                    namespace :  'microsoft.synapse/workspaces' 
                                    metricVisualization : {
                                      displayName :  'Activity runs ended' 
                                      resourceDisplayName : synapse001Name
                                   }
                                 }
                               ]
                                title :  'Sum of Activity runs ended for ${synapse001Name}' 
                                titleKind : 1
                                visualization : {
                                  chartType : 2
                                  legendVisualization : {
                                    isVisible : true
                                    position : 2
                                    hideSubtitle : false
                                 }
                                  axisVisualization : {
                                    x : {
                                      isVisible : true
                                      axisType : 2
                                   }
                                    y : {
                                      isVisible : true
                                      axisType : 1
                                   }
                                 }
                                  disablePinning : true
                               }
                             }
                           }
                         }
                    }
                }
            }
            {
              position: {
                x: 0
                y: 4
                colSpan: 6
                rowSpan: 4
              }
              metadata: {
                inputs: [
                  {
                    name: 'options'
                    isOptional: true
                  }
                  {
                    name: 'sharedTimeRange'
                    isOptional: true
                  }
                ]
                type: 'Extension/HubsExtension/PartType/MonitorChartPart'
                settings: {
                  content: {
                    options: {
                      chart: {
                        metrics: [
                          {
                            resourceMetadata: {
                              id: cosmosdbScope
                            }
                            name: 'ServerSideLatency'
                            aggregationType: 4
                            namespace: 'Microsoft.DocumentDB/databaseAccounts'
                            metricVisualization: {
                              displayName: 'Server Side Latency'
                              resourceDisplayName: cosmosdb001Name
                            }
                          }
                        ]
                        title: 'Avg Server Side Latency for ${cosmosdb001Name}'
                        titleKind: 1
                        visualization: {
                          chartType: 2
                          legendVisualization: {
                            isVisible: true
                            position: 2
                            hideSubtitle: false
                          }
                          axisVisualization: {
                            x: {
                              isVisible: true
                              axisType: 2
                            }
                            y: {
                              isVisible: true
                              axisType: 1
                            }
                          }
                          disablePinning: true
                        }
                      }
                    }
                  }
                }
              }
            }
            {
              position: {
                x: 6
                y: 4
                colSpan: 6
                rowSpan: 4
              }
              metadata: {
                inputs: [
                  {
                    name: 'options'
                    isOptional: true
                  }
                  {
                    name: 'sharedTimeRange'
                    isOptional: true
                  }
                ]
                type: 'Extension/HubsExtension/PartType/MonitorChartPart'
                settings: {
                  content: {
                    options: {
                      chart: {
                        metrics: [
                          {
                            resourceMetadata: {
                              id: iothubScope
                            }
                            name: 'jobs.failed'
                            aggregationType: 1
                            namespace: 'Microsoft.Devices/IotHubs'
                            metricVisualization: {
                              displayName: 'Failed jobs'
                              resourceDisplayName: iothub001Name
                            }
                          }
                        ]
                        title: 'Sum Failed jobs for ${iothub001Name}'
                        titleKind: 1
                        visualization: {
                          chartType: 2
                          legendVisualization: {
                            isVisible: true
                            position: 2
                            hideSubtitle: false
                          }
                          axisVisualization: {
                            x: {
                              isVisible: true
                              axisType: 2
                            }
                            y: {
                              isVisible: true
                              axisType: 1
                            }
                          }
                          disablePinning: true
                        }
                      }
                    }
                  }
                }
              }
            }
            {
              position: {
                x: 0
                y: 8
                colSpan: 6
                rowSpan: 4
              }
              metadata: {
                inputs: [
                  {
                    name: 'options'
                    isOptional: true
                  }
                  {
                    name: 'sharedTimeRange'
                    isOptional: true
                  }
                ]
                type: 'Extension/HubsExtension/PartType/MonitorChartPart'
                settings: {
                  content: {
                    options: {
                      chart: {
                        metrics: [
                          {
                            resourceMetadata: {
                              region: 'eastus2' 
                              resourceType: 'Microsoft.Sql/servers/databases'
                              subscription: {
                                subscriptionId: subscription().id
                                displayName: subscription().displayName
                                resourceDisplayName: subscription().displayName
                              }
                            }
                            name: 'connection_failed'
                            aggregationType: 1
                            namespace: 'Microsoft.Sql/servers/databases'
                            metricVisualization: {
                              displayName: 'Failed Connections'
                              resourceDisplayName: subscription().displayName
                            }
                          }
                        ]
                        title: 'Sum Failed Connections for ${sql001Name}'
                        titleKind: 1
                        visualization: {
                          chartType: 2
                          legendVisualization: {
                            isVisible: true
                            position: 2
                            hideSubtitle: false
                          }
                          axisVisualization: {
                            x: {
                              isVisible: true
                              axisType: 2
                            }
                            y: {
                              isVisible: true
                              axisType: 1
                            }
                          }
                          disablePinning: true
                        }
                        filterCollection: {
                          filters: [
                            {
                              key: 'Microsoft.ResourceGroupName'
                              operator: 0
                              values: [
                                resourceGroup().name
                              ]
                            }
                          ]
                        }
                        grouping: {
                          dimension: 'Microsoft.ResourceId'
                        }
                      }
                    }
                  }
                }
                filters: {
                  'Microsoft.ResourceGroupName': {
                    model: {
                      operator: 'equals'
                      values: [
                        resourceGroup().name
                      ]
                    }
                  }
                }
              }
            }
            {
              position: {
                x: 6
                y: 8
                colSpan: 6
                rowSpan: 4
              }
              metadata: {
                inputs: [
                  {
                    name: 'options'
                    isOptional: true
                  }
                  {
                    name: 'sharedTimeRange'
                    isOptional: true
                  }
                ]
                type: 'Extension/HubsExtension/PartType/MonitorChartPart'
                settings: {
                  content: {
                    options: {
                      chart: {
                        metrics: [
                          {
                            resourceMetadata: {
                              id: eventhubnamespaceScope
                            }
                            name: 'ServerErrors'
                            aggregationType: 1
                            namespace: 'Microsoft.EventHub/namespaces'
                            metricVisualization: {
                              displayName: 'Server Errors.'
                              resourceDisplayName: eventhubnamespace001Name
                            }
                          }
                        ]
                        title: 'Sum Server Errors for ${eventhubnamespace001Name}'
                        titleKind: 1
                        visualization: {
                          chartType: 2
                          legendVisualization: {
                            isVisible: true
                            position: 2
                            hideSubtitle: false
                          }
                          axisVisualization: {
                            x: {
                              isVisible: true
                              axisType: 2
                            }
                            y: {
                              isVisible: true
                              axisType: 1
                            }
                          }
                          disablePinning: true
                        }
                      }
                    }
                  }
                }
              }
            }
            {
              position: {
                x: 0
                y: 12
                colSpan: 6
                rowSpan: 4
              }
              metadata: {
                inputs: [
                  {
                    name: 'options'
                    isOptional: true
                  }
                  {
                    name: 'sharedTimeRange'
                    isOptional: true
                  }
                ]
                type: 'Extension/HubsExtension/PartType/MonitorChartPart'
                settings: {
                  content: {
                    options: {
                      chart: {
                        metrics: [
                          {
                            resourceMetadata: {
                              id: streamanalyticsScope
                            }
                            name: 'Errors'
                            aggregationType: 1
                            namespace: 'microsoft.streamanalytics/streamingjobs'
                            metricVisualization: {
                              displayName: 'Runtime Errors'
                              resourceDisplayName: streamanalytics001Name
                            }
                          }
                        ]
                        title: 'Sum Runtime Errors for ${streamanalytics001Name}'
                        titleKind: 1
                        visualization: {
                          chartType: 2
                          legendVisualization: {
                            isVisible: true
                            position: 2
                            hideSubtitle: false
                          }
                          axisVisualization: {
                            x: {
                              isVisible: true
                              axisType: 2
                            }
                            y: {
                              isVisible: true
                              axisType: 1
                            }
                          }
                          disablePinning: true
                        }
                      }
                    }
                  }
                }
              }
            }
            ]
        }
    ]  
      metadata  : {
          model  : {}
    }
}
}

/*

resource dashboardSql 'Microsoft.Portal/dashboards@2020-09-01-preview' = {
  name: '${dashboardName}-sql'
  location: location
  tags: tags
    properties  : {
      lenses  : [
        {
              order  : 0  
              parts  : [
                {
                      position  : {
                          x  : 0  
                          y  : 0  
                          rowSpan  : 4  
                          colSpan  : 6
                    }  
                      metadata  : {
                          inputs  : [
                            {
                              name: 'options'
                              isOptional: true
                            }
                            {
                              name: 'sharedTimeRange'
                              isOptional: true
                            }
                        ]  
                          type  : 'Extension/HubsExtension/PartType/MarkdownPart'
                          settings  : {
                              content  : {
                                options: {
                                 chart: {
                                   metrics: [
                                     {
                                       resourceMetadata: {
                                          id : sqlScope
                                       }
                                        name :  'CPU percentage' 
                                        aggregationType : 1
                                        namespace :  'Microsoft.Sql/servers/databases' 
                                        metricVisualization : {
                                          displayName :  'Percent of CPU utilization' 
                                          resourceDisplayName : sql001Name
                                       }
                                     }
                                   ]
                                    title :  'Total Percent of CPU utilization for ${sql001Name}' 
                                    titleKind : 1
                                    visualization : {
                                      chartType : 2
                                      legendVisualization : {
                                        isVisible : true
                                        position : 2
                                        hideSubtitle : false
                                     }
                                      axisVisualization : {
                                        x : {
                                          isVisible : true
                                          axisType : 2
                                       }
                                        y : {
                                          isVisible : true
                                          axisType : 1
                                       }
                                     }
                                      disablePinning : true
                                   }
                                 }
                               }
                             }
                        }
                    }
                }        
            ]
        }
    ]  
      metadata  : {
          model  : {}
    }
}
}*/

// Outputs
