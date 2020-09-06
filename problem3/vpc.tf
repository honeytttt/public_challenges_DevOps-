resource "aws_vpc" "vpc_devops" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_devops"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_devops.id

  tags = {
    Name = "gw_devops"
  }
}

resource "aws_route" "Public_route" {
  route_table_id         = "${aws_vpc.vpc_devops.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}


resource "aws_subnet" "sub_public_devops" {
  vpc_id     = aws_vpc.vpc_devops.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "sub_public_devops"
  }
}


resource "aws_security_group" "sg_devops" {
  name        = "sg_devops"
  description = "Allow ssh and http inbound traffic"
  vpc_id      = aws_vpc.vpc_devops.id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
 ingress {
    description = "Tomcat access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_devops"
  }
}




resource "aws_key_pair" "Kubernetes" {
  key_name   = "Kubernetes"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCutUr1eu9MNR005bFN9v9PyI0Hylu6vpXPlvBoRPJKE1WYKEup24FqPIcUgd1zqhiJVPZOwCR6Fn6iLE7oyE0hlby2agknIOPvLHzSumV9JnTEL4pBwQZi4MhEUnPH0J3AGPU29jEZgNnixPIR1Csywg7F2aO7LDgU4nQI/kWSKGN6qg4NYFPpBbgrfsoMup/BFKJOna25wer4Wegd5Xcv43bZCj7qbzCDM+iVBhS3e/Ei5lgqErit9r2dcMh1l2KtZpUBAuixTKswjUFWT22oodYlfZMzFIFz8qDFsgmf9BxtvD/c2VuqNq6r86hE3avupy38TvLTloxbCacDAILR"
}


resource "aws_instance" "Kube-Master" {

        vpc_security_group_ids = [ "${aws_security_group.sg_devops.id}" ]
        ami     =       "ami-000792f2117324fc6"
        instance_type   = "t2.medium"
        key_name        =       "kp_devops"
	subnet_id	=	 "${aws_subnet.sub_public_devops.id}" 
        associate_public_ip_address = true
	tags = {
                Name  = "Kube-Master"
  }

}


output "ec2_devops_public_ip" {
  value = ["${aws_instance.Kube-Master.*.public_ip}"]
}
