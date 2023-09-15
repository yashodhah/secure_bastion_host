module "ec2_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.3.1"

  name = "ec2_bastion"

  instance_type               = "t2.micro"
  subnet_id                   = element(module.main_vpc.private_subnets, 0)
  vpc_security_group_ids      = [module.ec2_bastion_sec_group.security_group_id]
  associate_public_ip_address = false

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies           = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  maintenance_options = {
    auto_recovery = "default"
  }

  tags = var.tags
}

module "ec2_bastion_sec_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "ec2_bastion_sec_group"
  description = "ec2 bastion group"
  vpc_id      = module.main_vpc.vpc_id

  egress_with_cidr_blocks = [
    {
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "Egress to VPC"
      cidr_blocks = var.main_vpc_cidr
    }
  ]

  tags = var.tags
}


