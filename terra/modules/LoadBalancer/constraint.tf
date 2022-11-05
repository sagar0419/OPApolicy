resource "rafay_opa_constraint" "block_loadbalancer_constraint" {
  metadata {
    name    = "block-loadbalancer"
    project     = var.project_name
    labels = {
      "rafay.dev/opa" = "constraint"
    }
  }
  spec {
    artifact {
      type = "Yaml"
      artifact {
        paths {
          name = "file://artifacts/BlockLoadbalancer/loadbalancerConstraint.yaml"
        }
      }
    }
    template_name = "block-loadbalancer"
    version = "v1"
    published =  true
  }
}