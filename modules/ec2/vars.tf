variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "instanceType" {
  description = "the instance type of your choice"
}

variable privateSubnet {
    description = "private subnet id"
}