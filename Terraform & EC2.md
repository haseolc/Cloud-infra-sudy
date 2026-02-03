### Terraform 설치

1. Windows Terminal에서 Ubuntu WSL 설치
    
    ```powershell
    wsl --install -d Ubuntu
    ```
    
2. Windows Terminal에서 Ubuntu 접속
    
    ![image.png](attachment:496136c6-53c7-4856-bc14-6b82aeb6575e:image.png)
    
    ![image.png](attachment:0b7a0ae7-80dc-4471-899a-1de9fa33ca3d:image.png)
    
3. HashiCorp 공식 문서 기준 Terraform 설치 (WSL Ubuntu)
    
    ```bash
    # 필수 패키지
    sudo apt update
    sudo apt install -y gnupg software-properties-common curl
    
    # HashiCorp GPG 키 등록
    curl -fsSL https://apt.releases.hashicorp.com/gpg | \
    sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    
    # HashiCorp 저장소 추가
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
    
    # Terraform 설치
    sudo apt update
    sudo apt install terraform
    ```
    
    설치 확인:
    
    ```bash
    terraform -version
    ```
    

### AWS 자격증명 붙이기

Terraform은 혼자 EC2 생성 불가 → AWS 권한(Access Key) 필요

AWS CLI 설치 → aws configure

1. **AWS CLI v2 공식 바이너리 설치  (WSL Ubuntu)**
    
    ```bash
    # 필요 패키지
    sudo apt update
    sudo apt install -y curl unzip
    
    # AWS CLI v2 다운로드
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    
    # 압축 해제
    unzip awscliv2.zip
    
    # 설치
    sudo ./aws/install
    
    # 설치 확인
    aws --version
    ```
    
2. **AWS 자격증명 연결 (WSL Ubuntu)**
    - AWS 콘솔에서 Access Key 생성 후 자격증명 연결
        - Access Key 생성 방법
            - IAM - 사용자 - 액세스 키 만들기
                
                ![image.png](attachment:fe1700ed-841a-4b76-abfd-9c0063c350db:image.png)
                
            - 사용 사례: CLI
                
                ![image.png](attachment:43403be2-75b2-429e-8e96-059949df206c:image.png)
                
            - 태그: `Terraform EC2 CLI key`
                
                ![image.png](attachment:314aa27d-65f5-4f8f-a33f-5830d99e1e8a:797cfe11-866b-4aec-a207-dbcfe81ff67a.png)
                
            - 액세스 키 생성 (.csv 파일 저장)
                
                ![비밀 액세스 키: raHBn4F1xKzL50q4JFcdZ6YT4+1DDqSYY/pCdp1m](attachment:4490ec4b-3129-469b-9f88-b0e1d72d70aa:image.png)
                
                비밀 액세스 키: raHBn4F1xKzL50q4JFcdZ6YT4+1DDqSYY/pCdp1m
                
                [kt_kim_accessKeys.csv](attachment:fa6ccb05-1bc7-4355-9552-e6351eb1135c:kt_kim_accessKeys.csv)
                
    
    ```bash
    aws configure
    
    AWS Access Key ID [None]: AKIAxxxxxxxx
    AWS Secret Access Key [None]: xxxxxxxxxxxx
    Default region name [None]: ap-northeast-2
    Default output format [None]: json
    ```
    
    AWS 연결 확인:
    
    ```bash
    aws sts get-caller-identity
    ```
    

### Terraform으로 EC2 생성

1. **작업 폴더 생성 (WSL Ubuntu)**
    
    ```bash
    mkdir tf-ec2
    cd tf-ec2
    ```
    
2. **Terraform 파일 생성 (WSL Ubuntu)**
    
    ```bash
    code .
    ```
    
    - 다음 창이 뜨면 Permanently allow host ‘wsl.localhost’ 체크 후 [Allow]
        
        ![image.png](attachment:cce92601-a073-4426-b7e0-286fd382b698:image.png)
        
    - [New File…] 버튼 눌러서 `main.tf` 파일 생성
        
        ![image.png](attachment:137b522c-b589-44fc-a959-59332e67e122:image.png)
        
    - `main.tf`에 작성
    
    ```bash
    provider "aws" {
      region = "ap-northeast-2"
    }
    
    data "aws_ami" "amazon_linux" {
      most_recent = true
    
      filter {
        name   = "name"
        values = ["al2023-ami-*-x86_64"]
      }
    
      owners = ["amazon"]
    }
    
    resource "aws_instance" "k3s_node" {
      ami           = data.aws_ami.amazon_linux.id
      instance_type = "t3.micro"
    
      tags = {
        Name = "dev-k3s-node-01"
        Environment = "dev"
        Project = "infra-auto"
      }
    }
    ```
    
3. **Terraform 실행 (WSL Ubuntu or VS Code Terminal?)**
    
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```
    
    - terraform init (참고)
        
        ```bash
        Initializing the backend...
        Initializing provider plugins...
        - Finding latest version of hashicorp/aws...
        - Installing hashicorp/aws v6.30.0...
        - Installed hashicorp/aws v6.30.0 (signed by HashiCorp)
        Terraform has created a lock file .terraform.lock.hcl to record the provider
        selections it made above. Include this file in your version control repository
        so that Terraform can guarantee to make the same selections by default when
        you run "terraform init" in the future.
        
        Terraform has been successfully initialized!
        
        You may now begin working with Terraform. Try running "terraform plan" to see
        any changes that are required for your infrastructure. All Terraform commands
        should now work.
        
        If you ever set or change modules or backend configuration for Terraform,
        rerun this command to reinitialize your working directory. If you forget, other
        commands will detect it and remind you to do so if necessary.
        ```
        
    - terraform plan (참고)
        
        ```bash
        data.aws_ami.amazon_linux: Reading...
        data.aws_ami.amazon_linux: Read complete after 1s [id=ami-08c2dc77a8f29051e]
        
        Terraform used the selected providers to generate the following execution plan. Resource actions are indicated
        with the following symbols:
          + create
        
        Terraform will perform the following actions:
        
          # aws_instance.k3s_node will be created
          + resource "aws_instance" "k3s_node" {
              + ami                                  = "ami-08c2dc77a8f29051e"
              + arn                                  = (known after apply)
              + associate_public_ip_address          = (known after apply)
              + availability_zone                    = (known after apply)
              + disable_api_stop                     = (known after apply)
              + disable_api_termination              = (known after apply)
              + ebs_optimized                        = (known after apply)
              + enable_primary_ipv6                  = (known after apply)
              + force_destroy                        = false
              + get_password_data                    = false
              + host_id                              = (known after apply)
              + host_resource_group_arn              = (known after apply)
              + iam_instance_profile                 = (known after apply)
              + id                                   = (known after apply)
              + instance_initiated_shutdown_behavior = (known after apply)
              + instance_lifecycle                   = (known after apply)
              + instance_state                       = (known after apply)
              + instance_type                        = "t3.micro"
              + ipv6_address_count                   = (known after apply)
              + ipv6_addresses                       = (known after apply)
              + key_name                             = (known after apply)
              + monitoring                           = (known after apply)
              + outpost_arn                          = (known after apply)
              + password_data                        = (known after apply)
              + placement_group                      = (known after apply)
              + placement_group_id                   = (known after apply)
              + placement_partition_number           = (known after apply)
              + primary_network_interface_id         = (known after apply)
              + private_dns                          = (known after apply)
              + private_ip                           = (known after apply)
              + public_dns                           = (known after apply)
              + public_ip                            = (known after apply)
              + region                               = "ap-northeast-2"
              + secondary_private_ips                = (known after apply)
              + security_groups                      = (known after apply)
              + source_dest_check                    = true
              + spot_instance_request_id             = (known after apply)
              + subnet_id                            = (known after apply)
              + tags                                 = {
                  + "Environment" = "dev"
                  + "Name"        = "dev-k3s-node-01"
                  + "Project"     = "infra-auto"
                }
              + tags_all                             = {
                  + "Environment" = "dev"
                  + "Name"        = "dev-k3s-node-01"
                  + "Project"     = "infra-auto"
                }
              + tenancy                              = (known after apply)
              + user_data_base64                     = (known after apply)
              + user_data_replace_on_change          = false
              + vpc_security_group_ids               = (known after apply)
        
              + capacity_reservation_specification (known after apply)
        
              + cpu_options (known after apply)
        
              + ebs_block_device (known after apply)
        
              + enclave_options (known after apply)
        
              + ephemeral_block_device (known after apply)
        
              + instance_market_options (known after apply)
        
              + maintenance_options (known after apply)
        
              + metadata_options (known after apply)
        
              + network_interface (known after apply)
        
              + primary_network_interface (known after apply)
        
              + private_dns_name_options (known after apply)
        
              + root_block_device (known after apply)
            }
        
        Plan: 1 to add, 0 to change, 0 to destroy.
        
        ───────────────────────────────────────────────────────────────────────────────────────────────────────────────
        
        Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these
        actions if you run "terraform apply" now.
        ```
        
    - terraform apply (참고)
        
        ```bash
        data.aws_ami.amazon_linux: Reading...
        data.aws_ami.amazon_linux: Read complete after 1s [id=ami-08c2dc77a8f29051e]
        
        Terraform used the selected providers to generate the following execution plan. Resource actions are indicated
        with the following symbols:
          + create
        
        Terraform will perform the following actions:
        
          # aws_instance.k3s_node will be created
          + resource "aws_instance" "k3s_node" {
              + ami                                  = "ami-08c2dc77a8f29051e"
              + arn                                  = (known after apply)
              + associate_public_ip_address          = (known after apply)
              + availability_zone                    = (known after apply)
              + disable_api_stop                     = (known after apply)
              + disable_api_termination              = (known after apply)
              + ebs_optimized                        = (known after apply)
              + enable_primary_ipv6                  = (known after apply)
              + force_destroy                        = false
              + get_password_data                    = false
              + host_id                              = (known after apply)
              + host_resource_group_arn              = (known after apply)
              + iam_instance_profile                 = (known after apply)
              + id                                   = (known after apply)
              + instance_initiated_shutdown_behavior = (known after apply)
              + instance_lifecycle                   = (known after apply)
              + instance_state                       = (known after apply)
              + instance_type                        = "t3.micro"
              + ipv6_address_count                   = (known after apply)
              + ipv6_addresses                       = (known after apply)
              + key_name                             = (known after apply)
              + monitoring                           = (known after apply)
              + outpost_arn                          = (known after apply)
              + password_data                        = (known after apply)
              + placement_group                      = (known after apply)
              + placement_group_id                   = (known after apply)
              + placement_partition_number           = (known after apply)
              + primary_network_interface_id         = (known after apply)
              + private_dns                          = (known after apply)
              + private_ip                           = (known after apply)
              + public_dns                           = (known after apply)
              + public_ip                            = (known after apply)
              + region                               = "ap-northeast-2"
              + secondary_private_ips                = (known after apply)
              + security_groups                      = (known after apply)
              + source_dest_check                    = true
              + spot_instance_request_id             = (known after apply)
              + subnet_id                            = (known after apply)
              + tags                                 = {
                  + "Environment" = "dev"
                  + "Name"        = "dev-k3s-node-01"
                  + "Project"     = "infra-auto"
                }
              + tags_all                             = {
                  + "Environment" = "dev"
                  + "Name"        = "dev-k3s-node-01"
                  + "Project"     = "infra-auto"
                }
              + tenancy                              = (known after apply)
              + user_data_base64                     = (known after apply)
              + user_data_replace_on_change          = false
              + vpc_security_group_ids               = (known after apply)
        
              + capacity_reservation_specification (known after apply)
        
              + cpu_options (known after apply)
        
              + ebs_block_device (known after apply)
        
              + enclave_options (known after apply)
        
              + ephemeral_block_device (known after apply)
        
              + instance_market_options (known after apply)
        
              + maintenance_options (known after apply)
        
              + metadata_options (known after apply)
        
              + network_interface (known after apply)
        
              + primary_network_interface (known after apply)
        
              + private_dns_name_options (known after apply)
        
              + root_block_device (known after apply)
            }
        
        Plan: 1 to add, 0 to change, 0 to destroy.
        
        Do you want to perform these actions?
          Terraform will perform the actions described above.
          Only 'yes' will be accepted to approve.
        
          Enter a value: yes
        
        aws_instance.k3s_node: Creating...
        aws_instance.k3s_node: Still creating... [00m10s elapsed]
        aws_instance.k3s_node: Creation complete after 13s [id=i-0f65105bdc47fcbd2]
        
        Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
        ```
        
    
    AWS 콘솔에서 인스턴스 생성 확인:
    
    ![image.png](attachment:a09c6505-34fa-43d9-962c-a9c020e9af25:image.png)
    
    - 인스턴스 요약
        
        ![image.png](attachment:c7e45df9-9b90-4716-8a20-ff7e109637e0:image.png)
        
4. **인스턴스 종료**
    
    ```bash
    terraform destroy
    ```
    
    AWS 콘솔에서 인스턴스 종료 확인:
    
    ![image.png](attachment:68145e4d-e0da-478e-bdd0-6d099ef9411a:image.png)
    
    - 콘솔에서 다음 확인
        - EC2: 0개
        - EBS: 0개
