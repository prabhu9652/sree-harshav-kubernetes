# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"
  # insert the 10 required variables here
  name                   = "k8s-mgmt-server"
  instance_count         = 1
  ami                    = "ami-09d56f8956ab235b3"
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  #monitoring             = true
  subnet_id              = module.vpc.public_subnets[0]
  #vpc_security_group_ids = [module.public_bastion_sg.this_security_group_id]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_admin.name
  tags = local.common_tags  
  user_data =  templatefile("kops_ssh_and_kubectl_install.tmpl",{rds_db_endpoint = "test"}) 
}

