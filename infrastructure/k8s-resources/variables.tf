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

variable "redis_release_name" {
  type = string
  default = "redis-queue"
}


###
# Redis variables
###

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
