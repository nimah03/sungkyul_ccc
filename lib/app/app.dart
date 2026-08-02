import 'package:flutter/material.dart';
import 'package:sungkyul_ccc/app/router/app_router.dart';
import 'package:sungkyul_ccc/core/theme/app_theme.dart';

/// 앱 루트 위젯.
///
/// 테마([AppTheme])와 라우터([appRouter])를 주입하는 [MaterialApp.router] 껍데기.
class SungkyulCccApp extends StatelessWidget {
  const SungkyulCccApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '성결대 CCC',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
