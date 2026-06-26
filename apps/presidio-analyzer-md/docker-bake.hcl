target "docker-metadata-action" {}

variable "APP" {
  default = "presidio-analyzer-md"
}

variable "VERSION" {
  // renovate: datasource=docker depName=mcr.microsoft.com/presidio-analyzer
  default = "2.2.362"
}

variable "SPACY_MODEL" {
  default = "en_core_web_md"
}

variable "SOURCE" {
  default = "https://github.com/microsoft/presidio"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  args = {
    VERSION     = "${VERSION}"
    SPACY_MODEL = "${SPACY_MODEL}"
  }
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output   = ["type=docker"]
  tags     = ["${APP}:${VERSION}"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}
