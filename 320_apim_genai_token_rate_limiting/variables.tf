variable "prefix" {
  description = "Prefix to be used for all resources in this example"
  type        = string
  default     = "320"
}

variable "openai_config" {
  default = {
    openai-uks = {
      name     = "openai-uks",
      location = "uksouth",
    },
    openai-swc = {
      name     = "openai-swc",
      location = "swedencentral",
    },
    openai-frc = {
      name     = "openai-frc",
      location = "francecentral",
    }
  }
}
