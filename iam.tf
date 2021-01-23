resource "aws_iam_role" "ec2-role" {
  name               = "ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2-role" {
  name = "ec2-role"
  role = "${aws_iam_role.ec2-role.name}"
}
resource "aws_iam_role_policy" "ec2-role-policy" {
  name   = "ec2-role-policy"
  role   = "${aws_iam_role.ec2-role.id}"
  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Effect": "Allow",
"Action": [
"s3:*"
],
"Resource":[
"arn:aws:s3:::mybucketb39000123",
"arn:aws:s3:::mybucketb39000123/*"
]
},
{
"Effect": "Allow",
"Action": "s3:ListAllMyBuckets",
"Resource": "arn:aws:s3:::*"
}
]
}
EOF
}

