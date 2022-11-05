output "loadbalancer_name" {
  value = "${rafay_opa_constraint.block_loadbalancer_constraint[*].name}"
}