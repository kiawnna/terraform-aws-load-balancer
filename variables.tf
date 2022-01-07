// Naming variables
variable "environment" {
  type = string
}

// ALB variables
variable "security_groups" {
  type = list(string)
  default = null
}
variable "subnets" {
  type = list(string)
  default = null
}
variable "cert_arn" {
  type = string
  default = null
}

variable "internal" {
  type = bool
  default = false
}
variable "load_balancer_type" {
  type = string
  default = "application"
}
variable "add_sticky_policy" {
  type = bool
  default = false
}
variable "create_listeners" {
  type = bool
  default = true
}