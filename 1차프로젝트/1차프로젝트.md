# 🚀 클라우드 자동화 및 보안과 백업 구축

> **목적:** 기존 프로젝트 초안을 기술적으로 보완하여 기획서·발표자료·Notion 문서 등 실무 수준으로 정리

---

## 1️⃣ 개발 환경과 인프라 환경 구분
* **개발 환경(Local):** 팀원 개인 PC (Windows)
* **운영 환경(Cloud):** AWS EC2 상의 Ubuntu Server
    * *설계 문서는 운영 환경을 중심으로 기술함*

## 2️⃣ Terraform의 역할 (IaC)
> Terraform은 서버를 가상화하는 도구가 아니라, **클라우드 인프라(AWS EC2, 네트워크 등)를 코드로 정의하고 자동 생성·관리하기 위한 IaC 도구**이다.

## 3️⃣ 인프라 자동화 단계
1. **Terraform:** AWS 인프라 정의 (EC2, 보안그룹, 네트워크)
2. **Ubuntu Server:** 자동 구축
3. **Docker:** 설치 및 컨테이너 실행 환경 구성
4. **Kubernetes:** 클러스터 구성

## 4️⃣ Kubernetes의 역할 (Orchestration)
> Kubernetes는 단순한 실행 도구가 아니라, 정의된 상태(Desired State)를 기준으로 **컨테이너의 배포, 확장, 복구를 자동으로 관리하는 오케스트레이션 플랫폼**이다.

## 5️⃣ GitHub Actions의 역할 (CI/CD)
> 코드 변경 시 **Terraform(인프라)**과 **Kubernetes(애플리케이션 배포)**를 자동으로 수행하는 파이프라인을 구성한다.

## ✅ 기술 스택 한눈 요약
| 구분 | 기술 | 역할 |
| :---: | :---: | :--- |
| **IaC** | Terraform | 클라우드 인프라 자동 생성 |
| **OS** | Ubuntu Server | 컨테이너 실행 환경 |
| **Container** | Docker | 애플리케이션 패키징 |
| **Orchestration** | Kubernetes | 배포·확장·복구 자동화 |
| **CI/CD** | GitHub Actions | 자동 배포 파이프라인 |

---
<br>

### 📂 커리큘럼 상세 보기 (목차)
*아래 항목을 클릭하면 세부 학습 내용으로 이동합니다.*

* 0️⃣ **[전체 큰 그림 – 서비스 운영의 본질](./개념/0_전체_큰_그림.md)**

* <details>
  <summary>1️⃣ <b>클라우드 & 인프라 기초</b></summary>

    * [1-1. 클라우드 기본](./개념/1-1_클라우드_기본.md)
    * [1-2. AWS 인프라 개념](./개념/1-2_AWS_인프라_개념.md)
  </details>

* <details>
  <summary>2️⃣ <b>IaC (Infrastructure as Code) & Terraform</b></summary>

    * [2-1. IaC 개념](./개념/2-1_IaC_개념.md)
    * [2-2. Terraform 핵심 개념](./개념/2-2_Terraform_핵심_개념.md)
  </details>

* 3️⃣ **[Linux 서버 운영 기초 (Ubuntu)](./개념/3_Linux_운영_기초.md)**

* <details>
  <summary>4️⃣ <b>Docker & 컨테이너</b></summary>

    * [4-1. Docker 개념](./개념/4-1_Docker_개념.md)
    * [4-2. Docker 실무 개념](./개념/4-2_Docker_실무_개념.md)
  </details>

* <details>
  <summary>5️⃣ <b>Kubernetes (핵심 운영 개념)</b></summary>

    * [5-1. 기본 리소스](./개념/5-1_기본_리소스.md)
    * [5-2. 트래픽 & 보안](./개념/5-2_트래픽_보안.md)
    * [5-3. 운영 개념](./개념/5-3_운영_개념.md)
  </details>

* 6️⃣ **[YAML & 선언형 설정](./개념/6_YAML_설정.md)**

* <details>
  <summary>7️⃣ <b>CI/CD & 자동화</b></summary>

    * [7-1. GitHub Actions](./개념/7-1_GitHub_Actions.md)
    * [7-2. 자동화 흐름](./개념/7-2_자동화_흐름.md)
  </details>

* <details>
  <summary>8️⃣ <b>보안 개념 (Ingress 중심)</b></summary>

    * [8-1. 네트워크 보안](./개념/8-1_네트워크_보안.md)
    * [8-2. SSL / TLS & HTTPS](./개념/8-2_SSL_TLS.md)
    * [8-3. 비밀 관리 (Secret Management)](./개념/8-3_Secret_Management.md)
    * [8-4. WAF (Web Application Firewall)](./개념/8-4_WAF.md)
  </details>

* <details>
  <summary>9️⃣ <b>백업 개념 (프로젝트 핵심)</b></summary>

    * [9-1. 백업 기본](./개념/9-1_백업_기본.md)
    * [9-2. 파일 백업](./개념/9-2_파일_백업.md)
    * [9-3. DB 백업 (확장)](./개념/9-3_DB_백업.md)
    * [9-4. 자동 백업](./개념/9-4_자동_백업.md)
  </details>

* 🔟 **[모니터링 & 운영](./개념/10_모니터링_운영.md)**

* 1️⃣1️⃣ **[장애 & 복구 시나리오](./개념/11_장애_복구_시나리오.md)**
