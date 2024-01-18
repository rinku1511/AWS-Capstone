data "aws_iam_role" "role-for-pipeline" {
  name = "AWSCodePipelineServiceRole-us-east-1-rinku-capstone"
}

data "aws_s3_bucket" "bucket-for-codepipeline-artifact-store" {
  bucket = "codepipeline-us-east-1-529422202836"
}

resource "aws_codepipeline" "codepipeline" {
  name     = var.codepipeline
  role_arn = data.aws_iam_role.role-for-pipeline.arn
  artifact_store {
    location = data.aws_s3_bucket.bucket-for-codepipeline-artifact-store.bucket
    type     = "S3"

  }

  stage {
    name = "Source"

    action {
      name             = "Source-stage"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = var.repository-name
        BranchName     = "main"

      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy-stage"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
        BucketName = "rinku-capstone-bucket"
        Extract    = true
      }
    }
  }
  tags = {
    "Name"  = "${var.tag-name}-pipeline"
    "Owner" = var.tag-owner
  }
}
