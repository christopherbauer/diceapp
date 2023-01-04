resource "aws_vpc" "this" {
	cidr_block = "10.2.0.0/16"
	enable_dns_hostnames = true
	enable_dns_support   = true
	
	tags = {
		Name        = "development"
		Environment = "development"
	}
}
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

	tags = {
		Name        = "development"
		Environment = "development"
	}
}