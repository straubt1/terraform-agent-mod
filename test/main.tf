variable "test_var" {
  description = "Dummy variable that can be used to force a variable error."
  type        = string
  default     = 10
}

variable "sleep" {
  default = 1
}

# Generate a change in the workspace
resource "random_pet" "main" {
  keepers = {
    always = timestamp()
  }
  length = var.test_var
}

data "external" "main" {
  program = ["bash", "${path.module}/sleep.sh", var.sleep]
}

resource "time_sleep" "main" {
  create_duration = "${var.sleep}s"

  triggers = {
    always = timestamp()
  }
}

output "pet_name" {
  value = random_pet.main.id
}
