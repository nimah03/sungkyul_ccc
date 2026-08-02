import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sungkyul_ccc/app/app.dart';
import 'package:sungkyul_ccc/app/bootstrap.dart';

Future<void> main() async {
  // 부팅 초기화(.env 로드 + Supabase) 완료 후 앱을 띄운다.
  await bootstrap();

  // Riverpod 전역 스코프로 앱을 감싼다.
  runApp(const ProviderScope(child: SungkyulCccApp()));
}
