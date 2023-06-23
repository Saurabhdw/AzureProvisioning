
@description('Name of the NSG to create')
param NSGid string
param delegations array
@description('Name of the Routetable to create')
param rtid string
param serviceEndpoints array
param privateEndpointNetworkPolicies string
param privateLinkServiceNetworkPolicies string

param vnetname string
param subnetname string
param subnetaddressprefix string


//get existing vnet
resource existingVNET 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: vnetname
}

//Subnet creation
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2020-07-01'  =  {
  name: subnetname
  parent: existingVNET
  properties: {
    addressPrefix: subnetaddressprefix
    networkSecurityGroup: empty(NSGid) ? json('null') : {id: NSGid}
    serviceEndpoints: serviceEndpoints
    routeTable: {
       id: rtid
       }
    delegations: delegations
    privateEndpointNetworkPolicies: privateEndpointNetworkPolicies
    privateLinkServiceNetworkPolicies: privateLinkServiceNetworkPolicies
    }
}


