resource "aws_subnet" "public_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_availability_zone_1_cidr
  availability_zone = var.availability_zone_1
  tags = {
    Environment = var.environment
    Service     = "deployment"
    Name        = "ecs | public | ${var.availability_zone_1}"
  }
}
resource "aws_subnet" "private_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_availability_zone_1_cidr
  availability_zone = var.availability_zone_1
  tags = {
    Environment = var.environment
    Service     = "deployment"
    Name        = "ecs | private | ${var.availability_zone_1}"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_availability_zone_2_cidr
  availability_zone = var.availability_zone_2
  tags = {
    Environment = var.environment
    Service     = "deployment"
    Name        = "ecs | public | ${var.availability_zone_2}"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_availability_zone_2_cidr
  availability_zone = var.availability_zone_2
  tags = {
    Environment = var.environment
    Service     = "deployment"
    Name        = "ecs | private | ${var.availability_zone_2}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  tags = {
    Environment = var.environment
    Service     = "deployment"
    Name        = "ecs | route | ${var.app_name}-${var.environment}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  tags = {
    Environment = var.environment
    Service     = "deployment"
    Name        = "ecs | route | ${var.app_name}-${var.environment}"
  }
}

resource "aws_route_table_association" "public_a_subnet" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private_a_subnet" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "public_b_subnet" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private_b_subnet" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}
resource "aws_eip" "this" {
  vpc = true
  tags = {
    "Environment" = var.environment
    "Service"     = "deployment"
    Name          = "eip | public | ${var.app_name}-${var.environment}"
  }
}

resource "aws_nat_gateway" "this" {
  subnet_id     = aws_subnet.public_a.id
  allocation_id = aws_eip.this.id
}

resource "aws_route" "public_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

resource "aws_route" "private_igw" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}
