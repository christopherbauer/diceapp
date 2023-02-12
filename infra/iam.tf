resource "aws_iam_user" "ci-github-actions" {
  name          = "ci-github-actions"
  force_destroy = true
  tags = {
    "Environment" = "corporate"
    Service       = "deployment"
  }
}
resource "aws_iam_policy" "github_push_to_ecr" {
  name        = "github_push_to_ecr"
  description = "Allow github to push new ecr images"
  path        = "/"
  policy      = data.aws_iam_policy_document.automation_ecr_push.json

  tags = {
    "Environment" = "corporate"
    "Service"     = "deployment"
  }
}

data "aws_iam_policy_document" "automation_ecr_push" {
  statement {
    sid = ""
    actions = [
      "ecr:PutLifecyclePolicy",
      "ecr:PutImageTagMutability",
      "ecr:StartImageScan",
      "ecr:CreateRepository",
      "ecr:PutImageScanningConfiguration",
      "ecr:UploadLayerPart",
      "ecr:BatchDeleteImage",
      "ecr:DeleteLifecyclePolicy",
      "ecr:DeleteRepository",
      "ecr:PutImage",
      "ecr:CompleteLayerUpload",
      "ecr:StartLifecyclePolicyPreview",
      "ecr:InitiateLayerUpload",
      "ecr:DeleteRepositoryPolicy",
      "ecr:BatchCheckLayerAvailability"
    ]
    resources = [module.corporate.diceapp_ecr_arn]
  }
  statement {
    sid = ""
    actions = [
      "ecr:GetAuthorizationToken",

    ]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy_attachment" "attach_ecr_push_to_ci_user" {
  user       = aws_iam_user.ci-github-actions.name
  policy_arn = aws_iam_policy.github_push_to_ecr.arn
}

resource "aws_iam_access_key" "deploy_key" {
  user = aws_iam_user.ci-github-actions.name
}

resource "aws_iam_role" "container_management" {
  name = "container_management"

  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json

  tags = {
    Environment = "corporate"
    Service     = "deployment"
  }
}

data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "fargate" {
  name   = "fargate-execution-role"
  role   = aws_iam_role.container_management.name
  policy = data.aws_iam_policy_document.fargate.json
}
data "aws_iam_policy_document" "fargate" {

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}
data "aws_iam_policy" "ecs_task_execution_role" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.container_management.name
  policy_arn = data.aws_iam_policy.ecs_task_execution_role.arn
}
