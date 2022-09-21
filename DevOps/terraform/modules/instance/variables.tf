variable "hc_path" {
  description = "Path for health-check"
  default     = "/health"
}

variable "hc_protocol" {
  description = "Protocol for health-check"
  default     = "HTTP"
}

variable "network_details" {
  description = "All network related details in this variable"
}

variable "instance_details" {}


variable "common_details" {
  description = "Common Details of the project"
}