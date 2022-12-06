module "resource_group" {
  source   = "../resource-group"
  
  name     = "rg-${var.deployment_name}-${var.location}"
  location = var.location
}
module "besu_container_group" {
  source              = "../besu-container-group"

  name                = "aci-${var.deployment_name}-${var.location}"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  external_host_name  = var.external_host_name
}
module "traffic_manager_endpoint" {
  source              = "../traffic-manager-endpoint"

  name                = "tme-${var.deployment_name}-${var.location}"
  resource_group_name = module.resource_group.resource_group_name
  profile_name        = var.profile_name
  target              = module.besu_container_group.this_fqdn

}
