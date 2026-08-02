import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sungkyul_ccc/app/router/app_router.dart';
import 'package:sungkyul_ccc/core/theme/app_colors.dart';
import 'package:sungkyul_ccc/features/auth/domain/entities/auth_user.dart';
import 'package:sungkyul_ccc/features/auth/presentation/controllers/auth_controller.dart';

/// 로딩(스플래시) 화면 — Canva 로딩 시안.
///
/// 브랜드 이미지를 잠시 보여주면서 저장된 세션을 확인하고,
/// 로그인 여부에 따라 로그인/홈으로 이동한다.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  /// 브랜드 노출을 위한 최소 스플래시 시간.
  static const _minSplash = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();
    unawaited(_bootstrap());
  }

  Future<void> _bootstrap() async {
    final start = DateTime.now();

    AuthUser? user;
    try {
      user = await ref.read(authControllerProvider.future);
    } on Object {
      user = null;
    }

    final elapsed = DateTime.now().difference(start);
    if (elapsed < _minSplash) {
      await Future<void>.delayed(_minSplash - elapsed);
    }

    if (!mounted) return;
    context.go(user != null ? AppRoutes.home : AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/branding/splash.png', fit: BoxFit.cover),
          const Align(
            alignment: Alignment(0, 0.8),
            child: SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(
                strokeWidth: 2.6,
                color: AppColors.accentPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
