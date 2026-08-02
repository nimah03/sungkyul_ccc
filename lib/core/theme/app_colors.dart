import 'package:flutter/material.dart';

/// 앱 색상 토큰.
///
/// Canva 시안(로딩/로그인/홈)에서 추출한 실제 HEX 값이다.
/// 위젯은 색을 직접 하드코딩하지 말고 반드시 이 토큰을 참조한다.
abstract final class AppColors {
  /// 브랜드 연녹 배경 (스플래시·로그인 전체 배경, 홈 환영 카드, 하단탭 바).
  static const Color background = Color(0xFFDDF7D2);

  /// 메인 그린 (로그인 버튼 등 주요 액션).
  static const Color primary = Color(0xFF8DB465);
  static const Color primaryDark = Color(0xFF6E9A46);

  /// 흰 카드/상단바.
  static const Color surface = Color(0xFFFFFFFF);

  /// 크림색 입력 필드/카드 배경.
  static const Color surfaceAlt = Color(0xFFF8F5EC);

  /// 시안 계열 카드 ("나의 기록", "CCC 일정").
  static const Color accentCyan = Color(0xFFC5FFFD);

  /// 로고·"접순" 라벨 등에 쓰이는 퍼플.
  static const Color accentPurple = Color(0xFF9F86D9);

  /// 포인트 옐로.
  static const Color accentYellow = Color(0xFFF5D98B);

  static const Color textPrimary = Color(0xFF2E2E2E);
  static const Color textSecondary = Color(0xFF8A8F98);

  /// 입력/카드 테두리.
  static const Color border = Color(0xFFE7E2D5);

  static const Color error = Color(0xFFD64545);
  static const Color success = Color(0xFF15803D);
  static const Color warning = Color(0xFFF59E0B);
}
