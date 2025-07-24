variable "region" {}

variable "ssh_key" {
  description = "SSH key pair for instance"
  type        = string
}

variable "instance_name" {
  description = "My instance's name"
  type        = string
}

variable "instance_type" {
  description = "My instance's type"
  type        = string
  default     = "t3.micro"
  validation {
    condition     = length(var.instance_type) > 0
    error_message = "Provide an instance's type."
  }
}

variable "root_block_size" {
  description = "Storage size"
  type        = number
  default     = 15
}

variable "root_volume_type" {
  description = "Storage type"
  type        = string
  default     = "gp3"
}

variable "instance_profile" {
  type    = string
  default = null
}

variable "allow_tcp_ports" {
  description = "List of ports to open for server"
  type        = list(string)
}

variable "allow_udp_ports" {
  description = "List of ports to open for server"
  type        = list(string)
  default     = [""]
}

variable "start_tcp_ports" {
  description = "List of ports to open for server"
  type        = list(string)
  default     = [""]
}

variable "end_tcp_ports" {
  description = "List of ports to open for server"
  type        = list(string)
  default     = [""]
}

variable "start_udp_ports" {
  description = "List of ports to open for server"
  type        = list(string)
  default     = [""]
}

variable "end_udp_ports" {
  description = "List of ports to open for server"
  type        = list(string)
  default     = [""]
}

variable "project_name" {
  description = "Project name"
  validation {
    condition     = length(var.project_name) > 3
    error_message = "The project_name value must be set and more than 3 symbols."
  }
}

variable "env" {
  description = "env"
  type        = string
}

