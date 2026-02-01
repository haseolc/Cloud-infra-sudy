# 7️⃣-1️⃣ GitHub Actions

## 1️⃣ Workflow

---

### 🏭 비유: 공장 전체 설계도

- 언제 가동할지
- 어떤 작업을
- 어떤 순서로 할지

---

### 💻 기술적 정의

> Workflow = 자동화 시나리오 전체
> 

---

### 📂 위치

```
.github/workflows/deploy.yaml

```

---

### 📄 예시

```yaml
name:DeploytoKubernetes

on:
push:
branches: [main ]

```

👉 “main 브랜치에 push되면 이 공장을 돌려라”

---

## 2️⃣ Job

---

### 🏗 비유: 공장 안의 공정 라인

- 빌드 라인
- 테스트 라인
- 배포 라인

---

### 💻 기술적 정의

> Job = 하나의 작업 단위 (하나의 가상 머신에서 실행)
> 

---

### 📄 예시

```yaml
jobs:
deploy:
runs-on:ubuntu-latest

```

- Job 하나 = VM 하나

---

### ⚠️ 중요한 특징

- Job 간은 기본적으로 **병렬**
- 순서 필요하면 `needs:` 사용

---

## 3️⃣ Step

---

### 🔧 비유: 공정 라인의 작업자

- 코드 체크아웃
- 도커 빌드
- kubectl 실행

---

### 💻 기술적 정의

> Step = Job 안에서 실행되는 개별 명령
> 

---

### 📄 예시

```yaml
steps:
-uses:actions/checkout@v3
-run:dockerbuild-tweb.

```

---

### 🔑 Step 종류

| 유형 | 설명 |
| --- | --- |
| uses | 미리 만들어진 액션 |
| run | 쉘 명령 실행 |

---

## 4️⃣ Trigger

---

### ⏰ 비유: 공장 가동 버튼

- 버튼 눌렀을 때
- 시간 되면
- 코드 바뀌면

---

### 💻 기술적 정의

> Trigger = Workflow를 실행시키는 조건
> 

---

### 📄 예시

```yaml
on:
push:
pull_request:
schedule:

```

---

### 🔍 자주 쓰는 Trigger

| Trigger | 의미 |
| --- | --- |
| push | 코드 푸시 시 |
| pull_request | PR 생성/수정 |
| schedule | 정해진 시간 |
| workflow_dispatch | 수동 실행 |

---

## 5️⃣ Secret

---

### 🔐 비유: 금고 속 열쇠

- 비밀번호
- 토큰
- 인증서

---

### 💻 기술적 정의

> Secret = GitHub에 암호화 저장된 민감 정보
> 

---

### 📦 예시

```yaml
env:
AWS_ACCESS_KEY_ID:${{secrets.AWS_ACCESS_KEY_ID}}

```

---

### ⚠️ 왜 필요한가?

- YAML에 비밀번호 쓰면 ❌
- GitHub 로그에 노출 ❌

---

### 🧠 실무 연결

- AWS 키
- Kubeconfig
- Docker Hub 토큰

---

## 🔄 전체 흐름 (한 장으로)

```
[ Git Push ]
      ↓
[ Trigger ]
      ↓
[ Workflow 실행 ]
      ↓
[ Job (VM 생성) ]
      ↓
[ Step 1: 코드 체크아웃 ]
[ Step 2: 빌드 ]
[ Step 3: 배포 ]

```

---

## 🧠 7-1 핵심 요약

- Workflow = 자동화 전체 시나리오
- Job = 하나의 작업 환경
- Step = 실제 실행 명령
- Trigger = 실행 조건
- Secret = 민감 정보 금고
