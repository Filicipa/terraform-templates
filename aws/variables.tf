variable "region" {}

variable "vpc_name" {}

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

variable "tcp_ports" {
  type        = list(number)
  default     = []
  description = "List of TCP ports to open (single ports)"
}

variable "udp_ports" {
  type        = list(number)
  default     = []
  description = "List of UDP ports to open (single ports)"
}

variable "tcp_port_ranges" {
  type = list(object({
    from = number
    to   = number
  }))
  default     = []
  description = "List of TCP port ranges"
}

variable "udp_port_ranges" {
  type = list(object({
    from = number
    to   = number
  }))
  default     = []
  description = "List of UDP port ranges"
}
