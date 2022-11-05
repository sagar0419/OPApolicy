resource "rafay_opa_constraint_template" "block_nodeport_template" {
  metadata {
    name    = "block-nodeport"
    project = var.project_name
    labels = {
      "rafay.dev/opa" = "template"
    }
  }
  spec {
    artifact {
      artifact {
        paths {
          name = "file://artifacts/BlockNodePort/nodeportTemplate.yaml"
        }
      }
      type = "Yaml"
    }
  }
}