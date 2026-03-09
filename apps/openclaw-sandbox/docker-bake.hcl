target "docker-metadata-action" {}

variable "APP" {
  default = "openclaw-sandbox"
}

variable "VERSION" {
  default = "1.0.0"
}

variable "SOURCE" {
  default = "https://github.com/solanyn/containers"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:${VERSION}"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
  ]
}
