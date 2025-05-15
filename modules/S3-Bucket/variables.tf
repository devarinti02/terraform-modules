variable "bucket_name" {
  type        = string
  default = "TF-Module_Bucket"
}

variable "versioning" {
  type        = bool
  default     = false
  description = "Enable versioning?"
}
