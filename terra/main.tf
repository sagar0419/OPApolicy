terraform {
  required_providers {
    rafay = {
      version = ">= 0.1"
      source  = "RafaySystems/rafay"
    }
  }
}

provider "rafay" {
  provider_config_file = var.rafay_config
}

# --------------------------------------------------------------------------------------------------------------------
# LoadBalancer 
# --------------------------------------------------------------------------------------------------------------------
module "LoadBalancer" {
  source       = "./modules/LoadBalancer"
  project_name = var.project_name
}

# --------------------------------------------------------------------------------------------------------------------
# NodePort
# --------------------------------------------------------------------------------------------------------------------
module "NodePort" {
  source       = "./modules/NodePort"
  project_name = var.project_name
}

# --------------------------------------------------------------------------------------------------------------------
# Volume
# --------------------------------------------------------------------------------------------------------------------
module "Volume" {
  source       = "./modules/Volume"
  project_name = var.project_name
}

# --------------------------------------------------------------------------------------------------------------------
# Policy
# --------------------------------------------------------------------------------------------------------------------
module "policy" {
  source          = "./modules/policy"
  project_name    = var.project_name
  policy_name     = var.policy_name
  constraint_list = [module.NodePort.nodeport_name, module.LoadBalancer.loadbalancer_name, module.Volume.volume_name]
}

# --------------------------------------------------------------------------------------------------------------------
# Blueprint
# --------------------------------------------------------------------------------------------------------------------
module "Blueprint" {
  source                 = "./modules/Blueprint"
  project_name           = var.project_name
  blueprint_name         = var.blueprint_name
  base_blueprint         = var.base_blueprint
  base_blueprint_version = var.base_blueprint_version
  policy_name            = var.policy_name
  policy_version         = var.policy_version
  profile_name           = var.profile_name
  profile_version        = var.profile_version
}

