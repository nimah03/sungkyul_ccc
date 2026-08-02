import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sungkyul_ccc/core/config/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 앱 부팅 초기화.
///
/// runApp 이전에 반드시 완료해야 하는 작업을 순서대로 수행한다:
///   1) Flutter 바인딩 초기화
///   2) `.env` 로드 (없으면 무시하고 진행)
///   3) 키가 준비된 경우에만 Supabase 초기화
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env 가 없거나 비어 있어도 앱은 실행되어야 하므로 실패를 흡수한다.
  try {
    await dotenv.load();
  } on Object {
    // .env 미존재 — Supabase 미연결 상태로 계속 진행
  }

  if (Env.hasSupabase) {
    await Supabase.initialize(
      url: Env.supabaseUrl,
      publishableKey: Env.supabaseKey,
    );
  }
}
