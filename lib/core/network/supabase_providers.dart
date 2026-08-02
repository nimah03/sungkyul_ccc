import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 전역 Supabase 클라이언트 provider.
///
/// 각 feature의 DataSource는 이 provider를 통해 클라이언트를 주입받는다.
/// (테스트 시 override 로 mock 클라이언트를 주입할 수 있다.)
///
/// 주의: 부팅 단계에서 Supabase.initialize 가 성공했을 때만 유효하다.
/// 키 미설정 상태에서 접근하면 예외가 발생하므로, 연결 여부는 Env.hasSupabase 로 확인한다.
final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => Supabase.instance.client,
);
