provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-0e3c5e2a6a4d7d6a5"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "763c702887906689b087ddce2625dc68a622086b"
    git_file             = "terraform/sample_instance/ec2.tf"
    git_last_modified_at = "2021-10-05 13:56:08"
    git_last_modified_by = "91682683+asiosio@users.noreply.github.com"
    git_modifiers        = "91682683+asiosio"
    git_org              = "asiosio"
    git_repo             = "terragoat"
    yor_trace            = "74bd91b5-edc5-4477-9e06-087ced60018b"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  subnet_id       = "subnet-045fa779639d7decf"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.id}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "4fe2076a6e5ada7d8549c3e060ca59145195f9c3"
    git_file             = "terraform/sample_instance/ec2.tf"
    git_last_modified_at = "2021-10-05 14:17:10"
    git_last_modified_by = "91682683+asiosio@users.noreply.github.com"
    git_modifiers        = "91682683+asiosio"
    git_org              = "asiosio"
    git_repo             = "terragoat"
    yor_trace            = "3c3b2da7-0062-4b3f-9248-91a24430b3db"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
