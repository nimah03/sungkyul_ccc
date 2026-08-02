import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 앱 환경변수 접근 진입점.
///
/// 값은 루트 `.env` 파일에서 로드되며(부팅 시 [dotenv] 초기화),
/// 비밀값은 코드에 하드코딩하지 않고 이곳을 통해서만 읽는다.
abstract final class Env {
  /// dotenv 미초기화(예: 위젯 테스트) 상황에서도 예외 없이 빈 값을 돌려준다.
  static String _read(String key) =>
      dotenv.isInitialized ? (dotenv.env[key] ?? '') : '';

  static String get supabaseUrl => _read('SUPABASE_URL');

  /// Supabase publishable key (신 API 키, `sb_publishable_...`).
  /// 기존 CCC 프로젝트가 사용하던 키 방식과 동일하다.
  static String get supabaseKey => _read('SUPABASE_PUBLISHABLE_KEY');

  /// Supabase 연결에 필요한 값이 모두 채워졌는지 여부.
  /// (초기 단계에선 비어 있을 수 있어, 이 값으로 초기화를 건너뛴다.)
  static bool get hasSupabase => supabaseUrl.isNotEmpty && supabaseKey.isNotEmpty;
}
