terraform {
  # 1. 테라폼 버전 및 필수 프로바이더 정의
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # 최신 안정화 버전 사용
    }
  }

  # 2. 테라폼 상태 파일(State) 관리 설정 (선택 사항)
  # 협업을 한다면 S3 버킷을 사용하는 것이 좋지만, 
  # 처음 연습 단계라면 이 backend 블록을 생략하여 로컬에 저장해도 됩니다.
  /*
  backend "s3" {
    bucket         = "7th-rooms-project-2026"
    key            = "k3s-project/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-lock-table" # 동시 수정 방지용
  }
  */
}

# 3. AWS 접속 정보 설정
provider "aws" {
  region = "ap-northeast-2" # 서울 리전
  
  # GitHub Actions에서 실행할 때는 아래 인증 정보를 직접 적지 않고, 
  # 환경 변수나 IAM Role을 통해 자동으로 인식하게 하는 것이 보안상 안전합니다.
}
