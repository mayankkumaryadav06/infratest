variable "db_engine" {
  default = "postgresql"
}

variable "common_details" {
  description = "Common Details of the project"
}

variable "db_network_details" {
  description = "All network details related to DB"
}

variable "db_details" {
  description = "All DB Details in this variables"
}
