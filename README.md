# Flutter 교육 자료

이 레포지토리는 Flutter 개발을 시작하려는 사람들을 위한 교육 자료를 제공합니다. 초보자부터 중급 개발자까지 다양한 레벨을 위한 자료와 예제 코드가 포함되어 있습니다.

## 목차

- [소개](#소개)
- [설치](#설치)
- [예제](#예제)
- [기본 개념](#기본-개념)
- [고급 주제](#고급-주제)
- [기여 방법](#기여-방법)
- [라이센스](#라이센스)

## 소개

Flutter는 구글에서 개발한 오픈소스 UI 소프트웨어 개발 키트(SDK)로, 단일 코드베이스로 iOS, Android, 웹, 데스크탑 애플리케이션을 개발할 수 있게 해줍니다. 이 레포지토리는 Flutter의 기본부터 고급 개념까지, 그리고 다양한 예제 코드로 구성되어 있습니다.

## 설치

이 자료를 사용하려면, 먼저 [Flutter SDK](https://flutter.dev/docs/get-started/install)와 Dart를 설치해야 합니다.

1. Flutter SDK 설치
   - [Flutter 설치 가이드](https://flutter.dev/docs/get-started/install) 참고

2. Flutter 프로젝트 생성
   ```bash
   flutter create my_flutter_project
   cd my_flutter_project

## 예제

- clean_1 (정우) : 플러터의 기본 앱을 클린 아키텍처를 이용해서 수정했습니다.
- clean_2 (정우) : 각각의 레이어에서 현재 상태를 업데이트 하는 로직을 추가해서, 보기 쉽게 어떻게 동작하는지 확인 가능합니다.
- server_1 (재혁) : 플러터 앱에서부터 서버와의 연결, 통신을 진행합니다.
- state (재혁) : 플러터 상태관리 로직을 설명 합니다. 

# state (리버팟 교육 예제 사용법)

실제로 코드를 사용해보고 싶으신 분들은 파이어베이스 프로젝트 생성 하시면 사용하실 수 있습니다.

```bash
curl -sL https://firebase.tools | bash
```

```bash
dart pub global activate flutterfire_cli
```

```bash
flutterfire configure --project={자신의 프로젝트 명}
```

플랫폼 선택창이 나오시면 AOS , IOS 선택 해주시면 됩니다.

주소 입력하는 창은 각자가 사용하고싶은 주소 사용해주시면 됩니다.


