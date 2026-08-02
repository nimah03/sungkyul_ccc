/// 여백·모서리 반경 토큰 (8pt 그리드 기반).
///
/// 매직 넘버(예: `EdgeInsets.all(16)`) 대신 이 상수를 사용해
/// 화면 간 간격 일관성을 유지한다. Canva 시안의 간격 규칙에 맞춰 조정한다.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  /// 카드/버튼 등 공용 모서리 반경.
  static const double radius = 12;
  static const double radiusSm = 8;
  static const double radiusLg = 20;
}
