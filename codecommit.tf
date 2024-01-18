resource "aws_codecommit_repository" "codecommit-repository" {
  repository_name = var.repository-name
  default_branch  = "main"
  tags = {
    "Name"  = "${var.tag-name}-repository"
    "Owner" = var.tag-owner
  }
}
