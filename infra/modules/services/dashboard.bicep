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
                                title :  'Sum Activity runs ended for ${synapse001Name}' 
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
                                          displayName :  'Pipeline runs ended' 
                                          resourceDisplayName : cosmosdb001Name
                                       }
                                     }
                                   ]
                                    title :  'Server Side Latency for ${cosmosdb001Name}' 
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
