variable "bucket_name" {
  type        = string
  default = "tf-module-bucket02"
}

variable "versioning" {
  type        = bool
  default     = false
  description = "Enable versioning?"
}
