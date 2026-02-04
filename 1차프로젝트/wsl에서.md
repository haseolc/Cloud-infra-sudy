# 1. 테라폼 1.7.0 버전(64비트) 다운로드
wget https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_linux_amd64.zip

# 2. 압축 풀기 도구 설치 (이미 있으면 건너뜀)
sudo apt update && sudo apt install unzip -y

# 3. 압축 풀기
unzip terraform_1.7.0_linux_amd64.zip

# 4. 실행 파일을 시스템 경로로 이동
sudo mv terraform /usr/local/bin/

# 5. 설치 확인
terraform -version

terraform -version 명령어가 성공했다면, 이제 아까 작성하신 코드가 있는 폴더에서 다음을 실행해 보세요.

terraform init

terraform plan

혹시 AWS 인증(aws configure)은 완료하셨나요? 설치 후에 init 단계에서 막힌다면 그 부분을 도와드릴게요.

🔐 2. AWS 인증 설정 (aws configure)
테라폼이 AWS에 인스턴스를 만들려면 "열쇠"가 필요합니다. WSL 터미널에 아래 명령어를 입력하세요.

Bash
aws configure
입력창이 뜨면 본인의 IAM 계정 정보를 차례대로 넣으시면 됩니다:

AWS Access Key ID: 발급받은 액세스 키

AWS Secret Access Key: 발급받은 비밀 키

Default region name: ap-northeast-2 (서울 리전)

Default output format: json

# 키 페어 파일이 있는 위치에서 실행하세요. (키 파일 권한 설정 필요)
chmod 400 infra-dev-key.pem 
ssh -i "infra-dev-key.pem" ec2-user@3.36.101.48
