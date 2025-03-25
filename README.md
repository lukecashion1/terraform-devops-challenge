# 🚀 DevOps Terraform Challenge

This project provisions a secure and scalable cloud infrastructure on AWS using Terraform. It includes a VPC with public and private subnets, an Application Load Balancer (ALB) with SSL termination, and a private EC2 instance running a web server.

## 📋 Table of Contents
- [Setup & Run Instructions](#-setup--run-instructions)
- [Project Structure](#-project-structure)
- [Assumptions](#-assumptions)
- [Verification Steps](#-verification-steps)
- [Terraform Outputs](#-terraform-outputs)

## 🔧 Setup & Run Instructions

### 1. Clone the Project
```bash
git clone https://github.com/lukecashion1/terraform-devops-challenge.git
cd terraform-devops-challenge
```

### 2. Generate SSH Key Pair
Run the following command in your terminal from the root directory:
```bash
ssh-keygen -t rsa -b 2048 -f mykey
```
> Note: You will be promoted for passphrase press ENTER twice

This generates:
- `mykey` (private key)
- `mykey.pub` (public key)

The public key is used to create an AWS key pair, while the private key is used to SSH into the EC2 instance (if needed from within the VPC).

### 3. Initialize and Deploy Infrastructure
Ensure you have Terraform installed, then run:
```bash
terraform init
terraform plan
terraform apply
```
> Note: Confirm the apply with 'yes' when prompted.

## 📌 Assumptions

- **AMI**: The latest Amazon Linux 2 AMI is used (retrieved dynamically)
- **SSL**: A self-signed certificate is used for HTTPS on the ALB (defined in `cert.tf`)
- **User Data**: A simple web server (e.g., Nginx) is installed and started using EC2 user data
- **Network Access**:
  - EC2 instance is launched in a private subnet
  - Can only be accessed through the ALB or via SSH from the VPC CIDR
  - No Bastion: Direct SSH to EC2 is not exposed publicly (good for security)

## ✅ Verification Steps

### 1. Access Web Server via ALB
After deployment, Terraform will output the ALB DNS Name:
```bash
alb_dns_name = <your-load-balancer>.elb.amazonaws.com
```

Access the web server:
- HTTPS: `https://<alb_dns_name>` (you may get a warning due to the self-signed certificate)

You should see the default Nginx (or Apache) welcome page.


## 📤 Terraform Outputs
After running `terraform apply`, you will see:
- ✅ ALB DNS Name
- ✅ Private IP of the EC2 instance

## 📁 Project Structure
```
.
├── cert.tf               # Self-signed certificate
├── ec2.tf                # EC2 instance and user data
├── keypair.tf            # SSH key pair resource
├── load_balancer.tf      # ALB, target group, listeners
├── network.tf            # VPC, subnets, route tables
├── outputs.tf            # Outputs for ALB DNS & EC2 IP
├── providers.tf          # AWS provider definition
├── security_groups.tf    # ALB & EC2 security groups
├── variables.tf          # Input variables
├── mykey / mykey.pub     # Generated SSH keys (locally)
└── README.md             # Setup document