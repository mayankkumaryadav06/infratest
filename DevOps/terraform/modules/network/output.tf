output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet" {
  value = module.public_subnet.subnet
}

output "private_subnet" {
  value = module.private_subnet.subnet
}