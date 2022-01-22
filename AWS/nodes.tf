resource "aws_iam_role" "node" {
  // define roles das máquinas da amanzon que serão utilizados no cluster
  name               = "${var.prefix}-${var.cluster-name}-role-node"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}    
POLICY
}

// policies usadas no ec2
resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node.name
}

// Criar grupos de máquinas que serão utilizados no meu cluster
resource "aws_eks_node_group" "node-1" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "node-1"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = aws_subnet.subnets[*].id
    instance_types = ["t3.micro"]
  // Define o scale de máquina
  scaling_config {
    desired_size = var.desired-size
    max_size     = var.max-size
    min_size     = var.min-size
  }
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}


resource "aws_eks_node_group" "node-2" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "node-2"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = aws_subnet.subnets[*].id
    instance_types = ["t3.micro"]
  // Define o scale de máquina
  scaling_config {
    desired_size = var.desired-size
    max_size     = var.max-size
    min_size     = var.min-size
  }
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}