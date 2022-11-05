resource "rafay_opa_constraint_template" "block_loadbalancer_template" {
  metadata {
    name    = "block-loadbalancer"
    project = var.project_name
    labels = {
      "rafay.dev/opa" = "template"
    }
  }
  spec {
    artifact {
      artifact {
        paths {
          name = "file://artifacts/BlockLoadbalancer/loadbalancerTemplate.yaml"
        }
      }
      type = "Yaml"
    }
  }
}