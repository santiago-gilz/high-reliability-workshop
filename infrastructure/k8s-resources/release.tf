locals {
  redis_env_vars = {}
}

resource "helm_release" "redis-queue" {
  name             = var.redis_release_name
  create_namespace = true
  namespace        = var.namespace_name
  chart            = "${path.module}/redis-queue"
  values = [
    templatefile("${path.module}/redis-queue/values.tpl.yaml",
      {
        redis_replicaCount  = var.redis_replicaCount
        redis_restartPolicy = var.redis_restartPolicy
        redis_env_vars      = indent(2, yamlencode(local.redis_env_vars))
        redis_registry      = var.redis_registry
        redis_pull_policy   = var.redis_pull_policy
        redis_short_name    = var.redis_short_name
        redis_long_name     = var.redis_long_name
        redis_port          = var.redis_port
  })]
}
