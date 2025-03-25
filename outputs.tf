output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app_lb.dns_name
}

output "ec2_private_ip" {
  description = "Private IP address of the web server EC2 instance"
  value       = aws_instance.web_server.private_ip
}
