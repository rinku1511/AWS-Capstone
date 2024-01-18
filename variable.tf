variable "region" {
  default = "us-east-1"
}


#Tags
variable "tag-owner" {
  default = " "
}

variable "tag-name" {
  default = "rinku"
}


#Bucket
variable "bucket-object" {
  default = "index.html"
}

variable "bucket-name" {
  default = "rinku-capstone-bucket"
}

variable "s3-source" {
  default = "index.html"
}

variable "content_type" {
  default = "text/html"
}

variable "policy-name" {
  default = "rinku-capstne-policy"
}


#Record
variable "record-name" {
  default = "rinku-capstone-record"
}

variable "record-type" {
  default = "CNAME"
}

variable "ttl" {
  default = 60
}


#Cloudfront
variable "object-static" {
  default = "index.html"
}

variable "ssl-viewer-certificate" {
  default = "sni-only"
}

variable "allowed-method" {
  default = ["GET", "HEAD"]
}

variable "cached-method" {
  default = ["GET", "HEAD"]
}

variable "viewer_protocol_policy" {
  default = "redirect-to-https"
}


#codecommit

variable "repository-name" {
  default = "rinku-capstone-repo"
}


#codepipeline

variable "codepipeline" {
  default = "rinku-capstone-codepipeline"
}


#SNS

variable "sns-name" {
  default = "rinku-capstone-pipeline-sns"
}

variable "protocol" {
  default = "email"
}

variable "email" {
  default = " "
}

variable "notification-name" {
  default = "pipeline-successfull-run"
}

variable "event-type" {
  default = ["codepipeline-pipeline-pipeline-execution-succeeded"]
}