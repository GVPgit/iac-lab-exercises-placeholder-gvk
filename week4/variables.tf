variable "bucket" {
  description = "This is for the bucket"
  type        = string
  default       = "mys3gvk"
}
variable "region" {
  description = "This is for the region"
  type        = string
  default       = "ap-southeast-2"
}
variable "prefix" {
  type        = string
  description = "Prefix to many of the resources created which helps as an identifier, could be company name, solution name, etc"
  default     = "tw-guru-iac-lab"
}
