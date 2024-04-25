variable "resource_group_name" {
  type        = string
  description = "Target resource group for deployment"
}

variable "tags" {
  type        = map(string)
  description = "The default tags for this azure resource"
}

variable "prefix" {
  type = string
}

variable "pod" {
  type = string
}


variable "logging_name" {
  type = string
}
variable "logging_resource_group_name" {
  type = string
}


variable "cohort" {
  type = number
}