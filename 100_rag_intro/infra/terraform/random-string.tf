resource "random_string" "random" {
  length      = 5
  min_numeric = 5
  numeric     = true
  lower       = true
  upper       = false
  special     = false
}
