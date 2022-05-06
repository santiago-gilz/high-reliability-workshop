locals {
  # ENV Variables
  redis_env_vars  = {}
  zipkin_env_vars = {}
  log_msg_proc_env_vars = {
    REDIS_HOST    = var.redis_long_name
    REDIS_PORT    = var.redis_port
    REDIS_CHANNEL = "log_channel"
    ZIPKIN_URL    = "http://${var.zipkin_long_name}:${var.zipkin_port}/api/v2/spans"
  }
  users_api_env_vars = {
    SERVER_PORT            = var.users_api_port
    JWT_SECRET             = "myfancysecret"
    SPRING_ZIPKIN_BASE_URL = "http://${var.zipkin_long_name}:${var.zipkin_port}"
  }
  todos_api_env_vars = {
    TODO_API_PORT = var.todos_api_port
    JWT_SECRET    = "myfancysecret"
    REDIS_HOST    = var.redis_long_name
    REDIS_PORT    = var.redis_port
    REDIS_CHANNEL = "log_channel"
    ZIPKIN_URL    = "http://${var.zipkin_long_name}:${var.zipkin_port}/api/v2/spans"
  }
  auth_api_env_vars = {
    AUTH_API_PORT     = var.auth_api_port
    JWT_SECRET        = "myfancysecret"
    USERS_API_ADDRESS = "http://${var.users_api_long_name}:${var.users_api_port}"
    ZIPKIN_URL        = "http://${var.zipkin_long_name}:${var.zipkin_port}/api/v2/spans"
  }
  frontend_env_vars = {
    PORT              = var.frontend_port
    AUTH_API_ADDRESS  = "http://${var.auth_api_long_name}:${var.auth_api_port}"
    TODOS_API_ADDRESS = "http://${var.todos_api_long_name}:${var.todos_api_port}"
    ZIPKIN_URL        = "http://${var.zipkin_long_name}:${var.zipkin_port}/api/v2/spans"
  }
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
  depends_on = [helm_release.zipkin]
  name       = var.log_msg_proc_release_name
  namespace  = var.namespace_name
  chart      = "${path.module}/log-message-processor"
  values = [
    templatefile("${path.module}/log-message-processor/values.tpl.yaml",
      {
        log_msg_proc_replicaCount  = var.log_msg_proc_replicaCount
        log_msg_proc_restartPolicy = var.log_msg_proc_restartPolicy
        log_msg_proc_env_vars      = indent(2, yamlencode(local.log_msg_proc_env_vars))
        log_msg_proc_registry      = var.log_msg_proc_registry
        log_msg_proc_pull_policy   = var.log_msg_proc_pull_policy
        log_msg_proc_short_name    = var.log_msg_proc_short_name
        log_msg_proc_long_name     = var.log_msg_proc_long_name
  })]
}

resource "helm_release" "users_api" {
  depends_on = [helm_release.zipkin]
  name       = var.users_api_release_name
  namespace  = var.namespace_name
  chart      = "${path.module}/users-api"
  values = [
    templatefile("${path.module}/users-api/values.tpl.yaml",
      {
        users_api_replicaCount  = var.users_api_replicaCount
        users_api_restartPolicy = var.users_api_restartPolicy
        users_api_env_vars      = indent(2, yamlencode(local.users_api_env_vars))
        users_api_registry      = var.users_api_registry
        users_api_pull_policy   = var.users_api_pull_policy
        users_api_short_name    = var.users_api_short_name
        users_api_long_name     = var.users_api_long_name
        users_api_port          = var.users_api_port
  })]
}

resource "helm_release" "todos_api" {
  ##
}

resource "helm_release" "auth_api" {
  ##
}

resource "helm_release" "frontend" {
  ##
}
