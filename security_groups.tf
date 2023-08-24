

resource "aws_security_group" "eks_worker_nodes_sg" {
  name        = "eks-worker-nodes-sg"
  vpc_id      = aws_vpc.main.id

  # Allow communication with the EKS control plane
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-worker-nodes-sg"
  }
}