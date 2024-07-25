###cloud vars
variable "default_zone_db" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr_db" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}


variable "vpc_name_db" {
  type        = string
  default     = "develop_db"
  description = "VPC network & subnet name"
}

variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v3"
  description = "Platform"
}


variable "destination_db_name" {
  type        = string
  default     = "db"
  description = "Destination name"
}
###ssh vars

#variable "vms_ssh_public_root_key" {
#  type        = string
#  default     = "/home/ubuntu/.ssh/id_ed25519.pub"
#  description = "ssh-keygen -t ed25519"
#}
