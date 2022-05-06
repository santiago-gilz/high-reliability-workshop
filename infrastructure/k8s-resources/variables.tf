###
# AKS variables
###

variable "aks_name" {
  type    = string
  default = "colombia40-aks"
}

variable "aks_rg" {
  type    = string
  default = "colombia40-rg"
}

variable "namespace_name" {
  type        = string
  description = "Your K8S namespace name"
  default = "demo"
}

variable "ingress_class" {
  type    = string
  default = "nginx"
}

###
# Redis variables
###

variable "redis_release_name" {
  type    = string
  default = "redis-queue"
}

variable "redis_replicaCount" {
  type    = number
  default = 1
}

variable "redis_restartPolicy" {
  type    = string
  default = "Always"
}

variable "redis_registry" {
  type    = string
  default = "redis"
}

variable "redis_pull_policy" {
  type    = string
  default = "IfNotPresent"
}

variable "redis_short_name" {
  type    = string
  default = "redis-queue"
}

variable "redis_long_name" {
  type    = string
  default = "workshop-redis-queue"
}

variable "redis_port" {
  type    = string
  default = "6379"
}

###
# Zipkin variables
###

variable "zipkin_release_name" {
  type    = string
  default = "zipkin"
}
variable "zipkin_replicaCount" {
  type    = number
  default = 1
}

variable "zipkin_restartPolicy" {
  type    = string
  default = "Always"
}

variable "zipkin_registry" {
  type    = string
  default = "openzipkin/zipkin"
}

variable "zipkin_pull_policy" {
  type    = string
  default = "IfNotPresent"
}

variable "zipkin_short_name" {
  type    = string
  default = "zipkin"
}

variable "zipkin_long_name" {
  type    = string
  default = "workshop-zipkin"
}

variable "zipkin_port" {
  type    = string
  default = "9411"
}

###
# Log msg proc variables
###

variable "log_msg_proc_release_name" {
  type    = string
  default = "log-message-processor"
}

variable "log_msg_proc_replicaCount" {
  type    = number
  default = 1
}

variable "log_msg_proc_restartPolicy" {
  type    = string
  default = "Always"
}

variable "log_msg_proc_registry" {
  type    = string
  default = "sgilz/col40-log-message-processor"
}

variable "log_msg_proc_pull_policy" {
  type    = string
  default = "IfNotPresent"
}

variable "log_msg_proc_short_name" {
  type    = string
  default = "log-message-processor"
}

variable "log_msg_proc_long_name" {
  type    = string
  default = "workshop-log-message-processor"
}

###
# Users api variables
###

variable "users_api_release_name" {
  type    = string
  default = "users-api"
}

variable "users_api_replicaCount" {
  type    = number
  default = 1
}

variable "users_api_restartPolicy" {
  type    = string
  default = "Always"
}

variable "users_api_registry" {
  type    = string
  default = "sgilz/col40-users-api"
}

variable "users_api_pull_policy" {
  type    = string
  default = "IfNotPresent"
}

variable "users_api_short_name" {
  type    = string
  default = "users-api"
}

variable "users_api_long_name" {
  type    = string
  default = "workshop-users-api"
}

variable "users_api_port" {
  type    = string
  default = "8083"
}

###
# todo api variables
###

variable "todos_api_release_name" {
  type    = string
  default = "todos-api"
}

variable "todos_api_replicaCount" {
  type    = number
  default = 1
}

variable "todos_api_restartPolicy" {
  type    = string
  default = "Always"
}

variable "todos_api_registry" {
  type    = string
  default = "sgilz/col40-todos-api"
}

variable "todos_api_pull_policy" {
  type    = string
  default = "IfNotPresent"
}

variable "todos_api_short_name" {
  type    = string
  default = "todos-api"
}

variable "todos_api_long_name" {
  type    = string
  default = "workshop-todos-api"
}

variable "todos_api_port" {
  type    = string
  default = "8082"
}


###
# auth api variables
###

variable "auth_api_release_name" {
  type    = string
  default = "auth-api"
}

variable "auth_api_replicaCount" {
  type    = number
  default = 1
}

variable "auth_api_restartPolicy" {
  type    = string
  default = "Always"
}

variable "auth_api_registry" {
  type    = string
  default = "sgilz/col40-auth-api"
}

variable "auth_api_pull_policy" {
  type    = string
  default = "IfNotPresent"
}

variable "auth_api_short_name" {
  type    = string
  default = "auth-api"
}

variable "auth_api_long_name" {
  type    = string
  default = "workshop-auth-api"
}

variable "auth_api_port" {
  type    = string
  default = "8081"
}

###
# frontend variables
###

variable "frontend_release_name" {
  type    = string
  default = "frontend"
}

variable "frontend_replicaCount" {
  type    = number
  default = 1
}

variable "frontend_restartPolicy" {
  type    = string
  default = "Always"
}

variable "frontend_registry" {
  type    = string
  default = "sgilz/col40-frontend"
}

variable "frontend_pull_policy" {
  type    = string
  default = "IfNotPresent"
}

variable "frontend_short_name" {
  type    = string
  default = "frontend"
}

variable "frontend_long_name" {
  type    = string
  default = "workshop-frontend"
}

variable "frontend_port" {
  type    = string
  default = "8080"
}

variable "frontend_enable_ingress" {
  type    = bool
  default = true
}

variable "frontend_ingress_class" {
  type    = string
  default = "nginx"
}
