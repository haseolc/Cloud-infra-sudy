# 6️⃣ YAML & 선언형 설정

---

## 1️⃣ YAML 문법

---

### 📜 비유: 보기 쉬운 체크리스트

- 컴퓨터가 읽지만
- 사람이 먼저 읽게 설계됨

---

### 💻 기술적 정의

> YAML = 사람이 읽기 쉬운 설정 파일 언어
> 

---

### 🔑 핵심 문법

```yaml
key:value

```

- 들여쓰기 = 구조
- 탭 ❌, 스페이스 ⭕
- `:` 뒤에 반드시 공백

---

### 📦 예시

```yaml
app:
name:web
replicas:3

```

👉 **계층 구조 = 들여쓰기**

---

## 2️⃣ yaml vs yml

---

### 🤔 결론부터

> 차이 없음
> 

---

### 📚 이유

- `.yml` → 타이핑 편의
- `.yaml` → 정식 표기

---

### 🧭 실무 팁

- 팀 내에서 하나로 통일만 하면 됨
- Kubernetes 공식 문서 → `.yaml` 선호

---

## 3️⃣ Kubernetes YAML 구조

---

### 🧱 비유: 설계도 4대 구성 요소

```markdown
1. 이게 뭐야?
2. 이름은 뭐야?
3. 원하는 상태는?
4. 구체적인 설정은?

```

---

### 📄 기본 구조

```yaml
apiVersion:
kind:
metadata:
spec:

```

---

### 🔍 각 항목 의미

| 필드 | 의미 |
| --- | --- |
| apiVersion | 이 리소스의 버전 |
| kind | Pod, Deployment 등 |
| metadata | 이름, 라벨 |
| spec | 원하는 상태 |

---

### 📦 예시

```yaml
apiVersion:apps/v1
kind:Deployment
metadata:
name:web
spec:
replicas:3

```

👉 **spec = 핵심**

---

## 4️⃣ Desired State 개념

---

### 🎯 비유: “이렇게 유지해줘”

- 지금 상태 ❌
- **원하는 상태 ⭕**

---

### 💻 기술적 정의

> Desired State = 시스템이 유지해야 할 목표 상태
> 

---

### 🧠 쿠버네티스의 역할

- 현재 상태 관찰
- desired state와 비교
- 다르면 자동 조정

---

### 🔁 예시

```yaml
replicas:3

```

- Pod 1개 → 3개로 증가
- Pod 5개 → 3개로 감소

👉 **운영자가 계속 감시할 필요 없음**

---

## 5️⃣ “명령서”가 아니라 “지침서”

---

### 📜 비유 비교

| 방식 | 설명 |
| --- | --- |
| 명령서 | “지금 이걸 실행해” |
| 지침서 | “항상 이 상태여야 해” |

---

### 💻 명령형 (Imperative)

```bash
kubectl run web --image=nginx

```

- 즉각 실행
- 기록 없음

---

### 📄 선언형 (Declarative)

```bash
kubectl apply -f web.yaml

```

- 상태 선언
- 지속적 관리 가능

---

### 🧠 왜 선언형이 중요한가?

- 재현 가능
- 자동 복구
- Git으로 관리 가능

👉 **운영 자동화의 핵심 철학**

---

# 🧠 6단계 핵심 요약

- YAML = 사람이 읽기 쉬운 설정 언어
- Kubernetes는 YAML로 상태를 선언
- spec = desired state
- 명령이 아니라 목표를 준다
- 쿠버네티스가 알아서 유지한다
