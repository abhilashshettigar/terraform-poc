variable "name" {
  description = "the name of your stack, e.g. \"demo\""
  default = "trt"
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
  default = "dev"
}

variable "aws-region" {
  type        = string
  description = "AWS region to launch servers."
  default     = "ap-southeast-1"
}


variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "192.168.0.0/16"
}

variable "az_count" {
  description = "count for subnet"
  default = 2
}
