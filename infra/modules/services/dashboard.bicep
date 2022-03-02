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
                          type  : 'Extension/HubsExtension/PartType/MarkdownPart'
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
                          name: 'sharedTimeRange'
                          isOptional: true
                        }
                    ]  
                      type  :   'Extension/HubsExtension/PartType/MarkdownPart'    
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
            ]
        }
    ]  
      metadata  : {
          model  : {}
    }
}
}

resource dashboardCosmosDB 'Microsoft.Portal/dashboards@2020-09-01-preview' = {
  name: '${dashboardName}-cosmosdb'
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
                                          id : cosmosdbScope
                                       }
                                        name :  'Server Side Latency' 
                                        aggregationType : 1
                                        namespace :  'Microsoft.DocumentDB/databaseAccounts' 
                                        metricVisualization : {
                                          displayName :  'Time taken to process requests (Server)' 
                                          resourceDisplayName : cosmosdb001Name
                                       }
                                     }
                                   ]
                                    title :  'Sum of Server Side Latency for ${cosmosdb001Name}' 
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
}

resource dashboardIoTHub 'Microsoft.Portal/dashboards@2020-09-01-preview' = {
  name: '${dashboardName}-iothub'
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
                                          id : iothubScope
                                       }
                                        name :  'Failed direct method invocations' 
                                        aggregationType : 1
                                        namespace :  'Microsoft.Devices/IotHubs' 
                                        metricVisualization : {
                                          displayName :  'Count of all failed direct method calls' 
                                          resourceDisplayName : iothub001Name
                                       }
                                     }
                                   ]
                                    title :  'Sum of all failed direct method calls for ${iothub001Name}' 
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
}

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
}

resource dashboardEventHub 'Microsoft.Portal/dashboards@2020-09-01-preview' = {
  name: '${dashboardName}-eventhub'
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
                                          id : eventhubnamespaceScope
                                       }
                                        name :  'Server Errors' 
                                        aggregationType : 1
                                        namespace :  'Microsoft.EventHub/namespaces' 
                                        metricVisualization : {
                                          displayName :  'Number of unprocessed requests because of error' 
                                          resourceDisplayName : eventhubnamespace001Name
                                       }
                                     }
                                   ]
                                    title :  'Sum of Server Errors for ${eventhubnamespace001Name}' 
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
}

resource dashboardStreamAnalytics 'Microsoft.Portal/dashboards@2020-09-01-preview' = {
  name: '${dashboardName}-streamanalytics'
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
                                          id : streamanalyticsScope
                                       }
                                        name :  'Runtime Errors' 
                                        aggregationType : 1
                                        namespace :  'Microsoft.StreamAnalytics/streamingjobs' 
                                        metricVisualization : {
                                          displayName :  'Query processing errors' 
                                          resourceDisplayName : streamanalytics001Name
                                       }
                                     }
                                   ]
                                    title :  'Sum of Runtime Errors for ${streamanalytics001Name}' 
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
}

// Outputs
