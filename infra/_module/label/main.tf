variable "name" {
  type = string
}

output "name" {
  value = "${terraform.workspace}_${var.name}"
}
