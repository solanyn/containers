target "docker-metadata-action" {}

variable "APP" {
  default = "rustical"
}

variable "RUSTICAL_VERSION" {
  // renovate: datasource=github-releases depName=lennart-k/rustical
  default = "v0.12.10"
}

variable "VERSION" {
  default = "${RUSTICAL_VERSION}"
}

variable "SOURCE" {
  default = "https://github.com/lennart-k/rustical"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  args = {
    VERSION = "${RUSTICAL_VERSION}"
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
