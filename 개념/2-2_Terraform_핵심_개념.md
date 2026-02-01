# 2️⃣-2️⃣ Terraform 핵심 개념

## 1️⃣ Provider

---

### 🌍 비유: 외국어 통역사

- “AWS야, EC2 하나 만들어줘”
- Terraform 혼자서는 AWS랑 말이 안 통함
- **Provider가 중간에서 통역**

---

### 💻 기술적 정의

> Provider = Terraform과 외부 서비스(AWS, GCP 등)를 연결하는 플러그인
> 

---

### 📌 예시

```hcl
provider "aws" {
  region = "ap-northeast-2"
}

```

의미:

- “AWS 서울 리전과 이야기할게”

---

### 🔍 이 프로젝트에서

- AWS Provider 사용
- EC2, Security Group 생성

👉 **Terraform의 입**

---

## 2️⃣ Resource

---

### 🧱 비유: 실제로 짓는 건물

- 도면만 있으면 안 됨
- **실제로 지을 대상**

---

### 💻 기술적 정의

> Resource = Terraform이 생성·관리하는 실제 인프라 객체
> 

---

### 📌 예시

```hcl
resource "aws_instance" "web" {
  ami           = "ami-xxx"
  instance_type = "t2.micro"
}

```

의미:

- EC2 인스턴스 하나 생성

---

### 🔍 이 프로젝트에서

- EC2
- 보안 그룹
- 키 페어

👉 **Terraform의 손**

---

## 3️⃣ Variable

---

### 🎛️ 비유: 설정 옵션 다이얼

- 같은 도면
- 다른 조건 적용 가능

---

### 💻 기술적 정의

> Variable = Terraform 코드의 입력값
> 

---

### 📌 예시

```hcl
variable "instance_type" {
  default = "t2.micro"
}

```

---

### 🧠 왜 쓰는가?

- 환경별 설정
- 코드 재사용
- 하드코딩 제거

---

### 🔍 이 프로젝트에서

- dev / prod 분리
- 서버 스펙 변경
- 리전 변경

👉 **유연성 담당**

---

## 4️⃣ Output

---

### 📢 비유: 결과 알림판

- “건물 완공!”
- 주소 알려줌

---

### 💻 기술적 정의

> Output = Terraform 실행 결과로 출력되는 값
> 

---

### 📌 예시

```hcl
output "public_ip" {
  value = aws_instance.web.public_ip
}

```

---

### 🔍 이 프로젝트에서

- EC2 퍼블릭 IP 출력
- CI/CD 후속 작업 연결

👉 **다음 단계와의 연결 고리**

---

## 5️⃣ State 파일

---

### 🧠 비유: 인프라의 기억장부

- “이 서버는 내가 만들었고”
- “이 포트는 열려 있고”

---

### 💻 기술적 정의

> State 파일 = Terraform이 관리 중인 실제 인프라 상태 기록
> 

---

### ⚠️ 매우 중요

- 코드 ≠ 현실
- Terraform은 State로 현실을 기억

---

### ❌ State 없으면

- 중복 생성
- 삭제 위험
- 관리 불가

---

### 🔍 이 프로젝트에서

- 로컬 → 원격 State (S3)
- 팀 협업 시 필수

👉 **Terraform의 뇌**

---

## 6️⃣ Plan / Apply 흐름

---

### 🧪 Plan

### 비유: 시뮬레이션

- “이렇게 바뀔 예정입니다”
- 실제 반영 ❌

```bash
terraform plan

```

---

### 🚀 Apply

### 비유: 실제 시공

- 계획대로 실행
- 인프라 생성/변경

```bash
terraform apply

```

---

### 🔁 전체 흐름

```
작성 → plan → 확인 → apply →state 갱신

```

---

### 🔍 이 프로젝트에서

- 실수 방지
- 변경 사항 사전 검토
- 안전한 배포

---

# 🧠 2-2단계 핵심 요약

- Provider는 외부 서비스와의 연결 통로
- Resource는 실제 생성 대상
- Variable은 유연성
- Output은 결과 전달
- State는 인프라의 현재 상태
- Plan/Apply는 안전한 실행 흐름
