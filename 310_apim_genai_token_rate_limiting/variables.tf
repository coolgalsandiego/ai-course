variable "prefix" {
  description = "Prefix to be used for all resources in this example"
  type        = string
  default     = "310-qa"
}

variable "openai_config" {
  default = {
    openai-uks = {
      name     = "openai-uks",
      location = "uksouth",
      # priority = 1,
      # weight   = 80
    },
    openai-swc = {
      name     = "openai-swc",
      location = "swedencentral",
      # priority = 1,
      # weight   = 10
    },
    openai-frc = {
      name     = "openai-frc",
      location = "francecentral",
      # priority = 1,
      # weight   = 10
    }
  }
}
