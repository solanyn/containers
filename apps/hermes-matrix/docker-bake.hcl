target "docker-metadata-action" {}

variable "APP" {
  default = "hermes-matrix"
}

variable "VERSION" {
  // renovate: datasource=pypi depName=hermes-agent
  default = "0.15.2"
}

variable "SOURCE" {
  default = "https://github.com/solanyn/containers"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  args = {
    VERSION = "${VERSION}"
  }
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
    "linux/arm64"
  ]
}
