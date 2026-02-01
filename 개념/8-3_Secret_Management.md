# 8️⃣-3️⃣ 비밀 관리 (Secret Management)

> 🔵 핵심 요약 (큰 그림)
> 
> 
> 비밀번호·토큰 같은 민감한 정보는
> 
> **코드 밖에서 관리하고, 필요한 순간에만 꺼내 쓴다**
> 

---

## 1️⃣ 환경 변수 (Environment Variable)

### 🧠 비유

> 금고 비밀번호를 종이에 쓰지 않고
머릿속에만 넣어두는 것
> 
- 문서에 적어두면 유출 위험
- 필요할 때만 기억해서 사용

---

### 💻 기술적 정의

> 프로그램 실행 시 외부에서 주입되는 설정 값
> 

---

### 📌 특징

- 코드와 분리
- 실행 환경마다 값 다르게 가능
- 로그에 안 찍히게 관리 가능

---

### 📄 예시

```bash
export DB_PASSWORD=secret123

```

```python
os.getenv("DB_PASSWORD")

```

---

## 2️⃣ `.env` 파일

### 🧠 비유

> 개인 금고 메모장 (외부 공유 금지)
> 
- 혼자만 보관
- 깃허브에 올리면 안 됨

---

### 💻 기술적 정의

> 환경 변수를 파일 형태로 관리하는 방식
> 

---

### 📄 예시

```
DB_USER=admin
DB_PASSWORD=secret123

```

---

### ⚠️ 매우 중요

```
.env

```

- **절대 Git에 커밋 ❌**

---

### 🧠 언제 쓰나?

- 로컬 개발
- 단일 서버
- 테스트 환경

---

## 3️⃣ GitHub Secrets

### 🧠 비유

> 회사 중앙 금고 + 자동 배포용 열쇠 관리실
> 
- 사람은 못 봄
- 자동화만 접근 가능

---

### 💻 기술적 정의

> GitHub가 암호화 저장하는 민감 정보 저장소
> 

---

### 📌 특징

- GitHub UI에서만 등록
- 로그에 마스킹됨
- Actions에서만 접근 가능

---

### 📄 사용 예시

```yaml
env:
AWS_ACCESS_KEY_ID:${{secrets.AWS_ACCESS_KEY_ID}}

```

---

## 🔗 전체 연결 구조

```
[ 개발자 ]
   ↓
.env (로컬)
   ↓
GitHub Secrets (배포)
   ↓
GitHub Actions
   ↓
Kubernetes / Terraform

```

---

## ⚠️ 잘못된 예 vs 올바른 예

### ❌ 잘못된 방식

```yaml
password:admin123

```

### ✅ 올바른 방식

```yaml
password:${DB_PASSWORD}

```

---

## 🧠 프로젝트 기준 정리

| 위치 | 방식 |
| --- | --- |
| 로컬 개발 | .env |
| CI/CD | GitHub Secrets |
| 컨테이너 | 환경 변수 주입 |
| Git 저장소 | 비밀 ❌ |

---

## ✅ 8-3 핵심 요약

- 환경 변수: 코드 밖 설정
- .env: 로컬 비밀 파일
- GitHub Secrets: 자동화용 금고
