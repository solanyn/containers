target "docker-metadata-action" {}

variable "APP" {
  default = "booktree"
}

variable "BOOKTREE_VERSION" {
  // renovate: datasource=github-tags depName=myxdvz/booktree
  default = "main"
}

variable "VERSION" {
  default = "${BOOKTREE_VERSION}"
}

variable "SOURCE" {
  default = "https://github.com/myxdvz/booktree"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  args = {
    VERSION = "${BOOKTREE_VERSION}"
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
