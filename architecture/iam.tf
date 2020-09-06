resource "aws_iam_role" "ecs_agent" {
  name = "ecs_agent"
  path = "/ecs/"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ecs_agent" {
  name = "ecs_agent"
  role = aws_iam_role.ecs_agent.name
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.ecs_agent.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_agent1" {
  role       = aws_iam_role.ecs_agent.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
