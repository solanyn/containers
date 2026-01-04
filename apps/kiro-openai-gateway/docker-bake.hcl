target "docker-metadata-action" {}

variable "APP" {
  default = "kiro-openai-gateway"
}

variable "VERSION" {
  // renovate: datasource=github-releases depName=jwadow/kiro-openai-gateway
  default = "v1.0.8"
}

variable "SOURCE" {
  default = "https://github.com/jwadow/kiro-openai-gateway"
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
