resource "rafay_opa_constraint_template" "block_volume_template" {
  metadata {
    name    = "block-volume"
    project = var.project_name
    labels = {
      "rafay.dev/opa" = "template"
    }
  }
  spec {
    artifact {
      artifact {
        paths {
          name = "file://artifacts/BlockVolume/blockVolumeTemplate.yaml"
        }
      }
      type = "Yaml"
    }
  }
}