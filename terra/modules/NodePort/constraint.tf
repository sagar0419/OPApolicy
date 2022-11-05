resource "rafay_opa_constraint" "block_nodeport_constraint" {
  metadata {
    name    = "block-nodeport"
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
          name = "file://artifacts/BlockNodePort/nodeportConstraint.yaml"
        }
      }
    }
    template_name = "block-nodeport"
    version = "v1"
    published =  true
  }
}