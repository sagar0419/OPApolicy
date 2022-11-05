resource "rafay_opa_constraint" "block_volume_constraint" {
  metadata {
    name    = "block-volume"
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
          name = "file://artifacts/BlockVolume/blockVolumeConstraint.yaml"
        }
      }
    }
    template_name = "block-volume"
    version = "v1"
    published =  true
  }
}