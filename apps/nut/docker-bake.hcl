target "docker-metadata-action" {}

variable "APP" {
  default = "nut"
}

variable "PYTHON_VERSION" {
  // renovate: datasource=docker depName=python
  default = "3.9"
}

variable "DEBIAN_VERSION" {
  // renovate: datasource=docker depName=debian
  default = "bookworm-slim"
}

variable "NUT_VERSION" {
  default = "master"
}

variable "VERSION" {
  default = "${NUT_VERSION}"
}

variable "SOURCE" {
  default = "https://github.com/blawar/nut"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  args = {
    PYTHON_VERSION = "${PYTHON_VERSION}"
    DEBIAN_VERSION = "${DEBIAN_VERSION}"
    NUT_VERSION = "${NUT_VERSION}"
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
