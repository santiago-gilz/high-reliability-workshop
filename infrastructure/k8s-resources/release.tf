locals {
  # ENV Variables
  redis_env_vars  = {}
  zipkin_env_vars = {}
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

resource "helm_release" "zipkin" {
  depends_on = [helm_release.redis-queue]
  name       = var.zipkin_release_name
  namespace  = var.namespace_name
  chart      = "${path.module}/zipkin"
  values = [
    templatefile("${path.module}/zipkin/values.tpl.yaml",
      {
        zipkin_replicaCount  = var.zipkin_replicaCount
        zipkin_restartPolicy = var.zipkin_restartPolicy
        zipkin_env_vars      = indent(2, yamlencode(local.zipkin_env_vars))
        zipkin_registry      = var.zipkin_registry
        zipkin_pull_policy   = var.zipkin_pull_policy
        zipkin_short_name    = var.zipkin_short_name
        zipkin_long_name     = var.zipkin_long_name
        zipkin_port          = var.zipkin_port
  })]
}

resource "helm_release" "log_msg_proc" {
  depends_on = [helm_release.redis-queue]
  name       = var.log_msg_proc_release_name
  namespace  = var.namespace_name
  chart      = "${path.module}/log-message-processor"
  values = [
    templatefile("${path.module}/log-message-processor/values.tpl.yaml",
      {
        log_msg_proc_replicaCount  = var.log_msg_proc_replicaCount
        log_msg_proc_restartPolicy = var.log_msg_proc_restartPolicy

        #ENV
        REDIS_HOST = var.redis_long_name
        REDIS_PORT = var.redis_port
        ZIPKIN_URL = "http://${var.zipkin_long_name}:${var.zipkin_port}/api/v2/spans"

        log_msg_proc_registry    = var.log_msg_proc_registry
        log_msg_proc_pull_policy = var.log_msg_proc_pull_policy
        log_msg_proc_short_name  = var.log_msg_proc_short_name
        log_msg_proc_long_name   = var.log_msg_proc_long_name
  })]
}
