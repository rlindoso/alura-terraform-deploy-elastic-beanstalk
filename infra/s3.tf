resource "aws_s3_bucket" "beanstalk_deploy_s3" {
  bucket = "${var.repositoryName}-deploys"
}

resource "aws_s3_object" "docker" {
  depends_on = [ 
    aws_s3_bucket.beanstalk_deploy_s3
  ]
  bucket = "${var.repositoryName}-deploys"
  key    = "${var.repositoryName}.zip"
  source = "${var.repositoryName}.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${var.repositoryName}.zip")
}