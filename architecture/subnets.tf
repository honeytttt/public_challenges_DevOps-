#resource "aws_subnet" "pub_subnet" {
#    vpc_id                  = aws_vpc.vpc.id
#    cidr_block              = "10.0.0.0/24"
#}


#resource "aws_subnet" "pub_subnet1" {
#    vpc_id                  = aws_vpc.vpc.id
#    cidr_block              = "10.0.1.0/24"
#}


data "aws_availability_zones" "available" {
  state = "available"
}

# e.g. Create subnets in the first two available availability zones

resource "aws_subnet" "pub_subnet" {
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"
  
	# ...

tags = {
                Name  = "ECS-Cluster"
  }
}

resource "aws_subnet" "pub_subnet1" {
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
 

	 # ...
tags = {
                Name  = "ECS-Cluster1"
  }

}
