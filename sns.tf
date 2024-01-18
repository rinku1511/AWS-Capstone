resource "aws_sns_topic" "sns-topic" {
  name = var.sns-name

}

resource "aws_sns_topic_subscription" "sns-subscription" {
  topic_arn              = aws_sns_topic.sns-topic.arn
  protocol               = var.protocol
  endpoint               = var.email
  endpoint_auto_confirms = true
}

data "aws_iam_policy_document" "notification-access" {
  statement {
    actions = ["sns:Publish"]

    principals {
      type        = "Service"
      identifiers = ["codestar-notifications.amazonaws.com"]
    }

    resources = [aws_sns_topic.sns-topic.arn]
  }
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.sns-topic.arn
  policy = data.aws_iam_policy_document.notification-access.json
}

resource "aws_codestarnotifications_notification_rule" "notification-rule" {
  detail_type    = "BASIC"
  event_type_ids = var.event-type
  name           = var.notification-name
  resource       = aws_codepipeline.codepipeline.arn
  target {
    address = aws_sns_topic.sns-topic.arn
  }
}
