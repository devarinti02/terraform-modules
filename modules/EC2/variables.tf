variable "ami" {
    type = string
    default  = "ami-01938df366ac2d954"
}

variable "availability_zone" {
    type = string
    default = "ap-southeast-1a"
}


variable "instance_type" {
    type = string
    default  = "t2.micro"
}

variable "key_name" {
    type = string
    default  = "web_server_01"
}

variable "instance_name" {
    type = string
    default  = "demo_instance"
}
