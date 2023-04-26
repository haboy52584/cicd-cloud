output "frontend_url" {
  description = "Front-end URL"
  value       = aws_instance.frontend.public_dns
}

