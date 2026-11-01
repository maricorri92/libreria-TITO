terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "test"
  secret_key = "test"

  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://floci:4566"
  }
}

resource "aws_s3_bucket" "sitio" {
  bucket = "libreria-tito-2026"
}

resource "aws_s3_bucket_website_configuration" "sitio" {
  bucket = aws_s3_bucket.sitio.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.sitio.id
  key          = "index.html"
  source       = "${path.module}/sitio-maria/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/sitio-maria/index.html")
}

resource "aws_s3_object" "nosotros" {
  bucket       = aws_s3_bucket.sitio.id
  key          = "nosotros.html"
  source       = "${path.module}/sitio-maria/nosotros.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/sitio-maria/nosotros.html")
}

resource "aws_s3_object" "contacto" {
  bucket       = aws_s3_bucket.sitio.id
  key          = "contacto.html"
  source       = "${path.module}/sitio-maria/contacto.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/sitio-maria/contacto.html")
}
