variable "prefix" {
  description = "Prefix to be used for all resources in this example"
  type        = string
  default     = "300swc"
}

variable "openAIConfig" {
  default = {
    openai-uks = {
      name     = "openaiuks",
      location = "uksouth",
      priority = 1,
      weight   = 80
    },
    openai-swc = {
      name     = "openaiswc",
      location = "swedencentral",
      priority = 1,
      weight   = 10
    },
    openai-frc = {
      name     = "openaifrc",
      location = "francecentral",
      priority = 1,
      weight   = 10
  } }
}
