terraform {
  # 1. 테라폼 실행 환경 버전 고정 (팀원 간 버전 일치)
  required_version = ">= 1.0.0"

  # 2. 사용할 클라우드 공급자(AWS) 설정
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # 3. 테라폼 상태 파일(State)을 S3와 DynamoDB에 저장
  # 주의: 이 블록을 활성화하려면 S3 버킷과 DynamoDB 테이블이 AWS에 이미 존재해야 합니다.
  backend "s3" {
    bucket         = "7th-rooms-project-2026"      # 실제 생성한 S3 버킷 이름
    key            = "k3s-project/terraform.tfstate" # 버킷 내 저장 경로 및 파일명
    region         = "ap-northeast-2"             # 버킷이 위치한 리전
    dynamodb_table = "terraform-lock-table"       # 충돌 방지용 DynamoDB 테이블 이름
    encrypt        = true                         # 상태 파일 암호화 여부
  }
}

# 4. AWS Provider 설정
provider "aws" {
  region = "ap-northeast-2" # 인프라를 생성할 대상 리전 (서울)
  
  # 프로젝트의 모든 리소스에 공통으로 붙을 태그 설정 (관리 용이)
  default_tags {
    tags = {
      Project   = "K3s-Project"
      ManagedBy = "Terraform"
      Owner     = "7th-room"
    }
  }
}
