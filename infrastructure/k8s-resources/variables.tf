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
  default = "redis-queue"
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
