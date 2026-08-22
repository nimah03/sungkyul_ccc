# 성결대학교 CCC 모바일 앱 (sungkyul_ccc)

성결대학교 CCC를 위한 Flutter 모바일 앱입니다. QT·전도 기록·기도노트·순장일지·공지·일정 등의
기능을 **단계(Phase)별로** 완성해 나갑니다.

## 기술 스택

- **Flutter / Dart**
- **Riverpod** — 상태 관리
- **go_router** — 라우팅
- **Supabase** — 백엔드 (기존 CCC 프로젝트 연동 예정)
- **flutter_dotenv** — 환경변수
- **very_good_analysis** — 린트

## 프로젝트 구조 (Feature-first + Clean Architecture)

```
lib/
├─ app/                  # 앱 진입점·부팅·테마·라우터
│  ├─ app.dart
│  ├─ bootstrap.dart     # .env 로드 + Supabase 초기화
│  └─ router/
├─ core/                 # 공통 인프라 (config·theme·error·network)
├─ shared/               # 공용 위젯
└─ features/             # 기능 단위 모듈
   ├─ auth/              #   ├─ domain / data / presentation
   │  ├─ domain/         #   │  엔티티·저장소 인터페이스
   │  ├─ data/           #   │  저장소 구현 (현재 Mock)
   │  └─ presentation/   #   │  컨트롤러·화면
   └─ home/
```

각 feature는 `domain`(엔티티·저장소 계약) → `data`(구현) → `presentation`(컨트롤러·UI)
계층으로 나뉩니다.

## 진행 상황

| Phase | 내용 | 상태 |
|------|------|------|
| 0 | 프로젝트 스캐폴딩·테마·부팅 | ✅ 완료 |
| 1 | 스플래시 · 로그인 · 홈(앱 셸) | ✅ 완료 |
| 2+ | QT · 전도 기록 · 기도노트 · 순장일지 · 공지 · 일정 | ⏳ 예정 |

> 로그인은 현재 `MockAuthRepository`로 동작합니다. Supabase 연동 시
> `authRepositoryProvider` 구현만 교체하면 화면 수정 없이 실 서버 인증으로 전환됩니다.

## 시작하기

```bash
# 1) 의존성 설치
flutter pub get

# 2) 환경변수 설정 (Supabase 연동 시)
cp .env.example .env   # 이후 .env 에 실제 값 입력

# 3) 실행
flutter run             # 연결된 기기/에뮬레이터
flutter run -d chrome   # 웹 미리보기
```

## 개발 규칙

- **UI는 Canva 시안 기준**으로 구현하고, 색·간격은 `core/theme` 토큰(`AppColors`, `AppSpacing`)만 참조합니다.
- **비밀값은 커밋 금지** — `.env`는 `.gitignore` 처리되어 있으며 템플릿은 `.env.example`을 사용합니다.
- 커밋 전 `flutter analyze`(무경고)와 `flutter test` 통과를 유지합니다.
