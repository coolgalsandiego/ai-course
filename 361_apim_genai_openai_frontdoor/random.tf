resource "random_string" "random" {
  length      = 5
  special     = false
  lower       = true
  upper       = false
  min_numeric = 5
}
