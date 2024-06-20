variable "region" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "app" {
  description = "App name"
  type        = string
  default     = "hello"
}

variable "env" {
  description = "App environment"
  type        = string
  default     = "development"
}

variable "image" {
  description = "Docker image to use"
  type        = string
  default     = "mblazevictestacc/helloapi:latest"
}