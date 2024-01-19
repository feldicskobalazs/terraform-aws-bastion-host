# AWS Bastion Host Architecture

## Overview

This project automates the deployment of a secure bastion host structure on AWS. This infrastructure allows for a highly controlled and monitored access point to your private instances, enhancing the security of your AWS environment.

## Features

- **Secured Access**: Leverage bastion hosts to establish a highly secure access point to your private instances.
- **Centralized Monitoring**: Strengthen security measures by closely monitoring and controlling access through a centralized entry point.
- **Streamlined Deployment**: Simplify and expedite the deployment process using Terraform.

## Technology Stack

- **Terraform**: Employ this Infrastructure as Code (IaC) tool to automate the deployment of your infrastructure.
- **AWS**: Utilize the AWS cloud platform to host the bastion host architecture.

## Prerequisites

Ensure the following prerequisites are installed on your local machine:

- **Terraform**: [Download and Install Terraform](https://www.terraform.io/downloads.html)
- **AWS CLI**: [Install and Configure AWS CLI](https://aws.amazon.com/cli/)

## Usage

1. **Clone the repository:**

    ```bash
    git clone git@github.com:feldicskobalazs/terraform-aws-bastion-host.git
    cd terraform-aws-bastion-host
    ```

2. **Initialize Terraform:**

    ```bash
    terraform init
    ```

3. **Review the deployment plan:**

    ```bash
    terraform plan
    ```

4. **Apply the Terraform configuration:**

    ```bash
    terraform apply
    ```

    Confirm the changes by typing `yes` and pressing Enter.

5. **Access the Bastion Hosts:**

    Upon completion, access the bastion host through SSH using the IP address provided by AWS.

## Cleanup

To dismantle the created resources:

```bash
terraform destroy
