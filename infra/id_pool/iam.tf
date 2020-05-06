data "aws_iam_policy_document" "assume_policy" {
  statement {
    effect = "Allow"
    principals {
      type = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }
    condition {
      test = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"
      values = [aws_cognito_identity_pool.id_pool.id]
    }
    condition {
      test = "ForAnyValue:StringLike"
      variable = "cognito-identity.amazonaws.com:amr"
      values = ["authenticated"]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
  }
}

resource "aws_iam_role" "auth_user_role" {
  name = "${module.id_label.name}_role"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
}

resource "aws_iam_role_policy_attachment" "auth_user_policy_attachment" {
  name = "${module.id_label.name}_attachment"
  role = "aws_iam_role.auth_user_role.name"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}