resource "rafay_opa_policy" "soft_policy" {
  metadata {
    name    = var.policy_name
    project = var.project_name
  }
  spec {
    constraint_list {
      name = var.constraint_list
      version = "v1"
    }
    sharing {
      enabled = false
    }
    version = "v0"
  }
}