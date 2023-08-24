# IAM role assumed by the EKS control panel.
resource "aws_iam_role" "eks_role" {
    name = "eks_role"
    
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole",
                Effect = "Allow",
                Principal = {
                    Service = "eks.amazonaws.com"
                }
            }
        ]
    })
}

# IAM policy attached to the EKS control plane role for necessary permissions.
resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
    role = aws_iam_role.eks_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "my_cluster" {
    name = "my-cluster"
    role_arn = aws_iam_role.eks_role.arn
    
    vpc_config {
        subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
    }
    
    depends_on = [
        aws_iam_role_policy_attachment.eks_policy_attachment
    ]
}

# IAM role assumed by the EKS worker nodes.
resource "aws_iam_role" "eks_node_role" {
    name = "eks_node_role"
    
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Action = "sts:AssumeRole",
                Effect = "Allow",
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}

# IAM policy attached to the EKS worker node role for necessary permissions.
resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment_worker" {
    role = aws_iam_role.eks_node_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# IAM policy attached to the EKS worker node role for necessary permissions.
resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment_container" {
    role = aws_iam_role.eks_node_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# IAM policy attached to the EKS worker node role for necessary permissions.
resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment_cni" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# The EKS cluster itself.
resource "aws_eks_node_group" "my_node_group" {
    cluster_name = aws_eks_cluster.my_cluster.name
    node_group_name = "my-node-group"
    node_role_arn = aws_iam_role.eks_node_role.arn
    subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
    security_groups_ids = aws_security_group.eks_worker_nodes_sg.id
    
    scaling_config {
        desired_size = 2
        max_size = 3
        min_size = 1
    }
}