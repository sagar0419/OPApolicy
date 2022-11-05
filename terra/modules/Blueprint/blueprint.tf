resource "rafay_blueprint" "opa-blueprint" {
  metadata {
    name    = var.blueprint_name
    project = var.project_name
  }
  spec {
    version = "v0"
    base {
      name    = var.base_blueprint
      version = var.base_blueprint_version
    }
    default_addons {
      enable_ingress    = false
      enable_logging    = false
      enable_monitoring = false
      enable_vm         = false
      }
    drift {
      action  = "Deny"
      enabled = false
    }   
    opa_policy{
      opa_policy {
        enabled = true
        name = var.policy_name
        version = var.policy_version        
      }
      profile {
        name = var.profile_name
        version = var.profile_version
      }  
    }
  }
}