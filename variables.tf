variable "location" {
  type = string
}

variable "instance_id" {
  type    = number
  default = 0
}

variable "prefix" {
  type = string
}

variable "env" {
  type = string
}

variable "purpose" {
  type = string
}

variable "cohort" {
  type = number
}

variable "id" {
  type = number
}


variable "pods" {
  type        = set(string)
  description = "Collection of pods"
}