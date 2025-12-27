target "docker-metadata-action" {}

variable "APP" {
  default = "whisparr"
}

variable "VERSION" {
  // renovate: datasource=git-refs depName=https://github.com/Whisparr/Whisparr rev-prefix=v rev-suffix=-eros
  default = "3.0.1.1349"
}

variable "SOURCE" {
  default = "https://github.com/Whisparr/Whisparr"
}

variable "ALPINE_VERSION" {
  // renovate: datasource=docker depName=alpine
  default = "3.22"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    ALPINE_VERSION = "${ALPINE_VERSION}"
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
