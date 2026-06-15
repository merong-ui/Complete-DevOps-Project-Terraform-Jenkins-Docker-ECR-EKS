# Create the VPC (an isolated network where I launch AWS resources)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "devops-vpc"
  }

}

# Create a Public Subnet (Where Jenkins & App will live)
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# NAT Gateway (for private subnet outbound internet access)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "devops-nat-gateway"
  }

  depends_on = [aws_internet_gateway.gw]
}

# Create an Internet Gateway (The "Door" at my private network to the internet)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Create a Route Table (The "GPS" that tell data where to go.)
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# This connects Subnet to Route Table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

# Private Subnet (for backend, EKS nodes, etc.)

resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-1a"

    # REQUIRED for EKS
    "kubernetes.io/cluster/devops-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = "1"
  }
}

resource "aws_subnet" "private_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-1b"

    # REQUIRED for EKS
    "kubernetes.io/cluster/devops-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = "1"
  }
}

# Route Table for Private Subnet
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

#Associate Private Subnet with NAT Route Table
resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_1a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_1b" {
  subnet_id      = aws_subnet.private_1b.id
  route_table_id = aws_route_table.private_rt.id
}