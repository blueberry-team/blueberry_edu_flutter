# Clean Architecture

클린 아키텍처는 의존성 규칙(Dependency Rule)을 통해 계층 간의 의존성을 명확히 하고, 유지보수성과 확장성을 높이는 소프트웨어 설계 방식입니다.

## Architecture Layers

```
      [ Presentation Layer ]
               |
      [ Domain Layer ]
               |
      [ Data Layer ]
```

### 1. Presentation Layer (UI)

- 사용자가 인터페이스를 통해 데이터를 입력하거나 결과를 보는 계층입니다.
- **구성요소:** Activity, Fragment, ViewModel
- **의존성:** Domain Layer만 참조 가능.

### 2. Domain Layer (Logic)

- 애플리케이션의 핵심 비즈니스 로직과 규칙을 정의하는 계층입니다.
- **구성요소:** Use Cases, 인터페이스(Repository)
- **의존성:** 독립적이며, 어떠한 계층에도 의존하지 않음.

### 3. Data Layer

- 데이터베이스, 네트워크 통신, API와 같은 외부 요소와 상호작용합니다.
- **구성요소:** Repository 구현체, 데이터 소스(Local, Remote)
- **의존성:** Domain 계층에만 의존.

---

## Dependency Rule

1. 안쪽 계층은 바깥쪽 계층을 알지 못합니다.
2. 모든 계층의 의존성은 `안쪽 방향`으로만 흐릅니다.

---

## Benefits

- 높은 **유지보수성** 및 **테스트 용이성**
- 각 계층의 **독립성**으로 인해 변경이 다른 계층에 영향을 주지 않음
- 비즈니스 로직의 재사용성과 확장성 증대

---

## Example Project Structure (Android)

```
/app /presentation -> UI & View Models /domain -> Use Cases, Repository Interfaces /data -> Repository Implementations, Local/Remote Data Sources
```

