output "subnet" {
  value = aws_subnet.this.*.id
}