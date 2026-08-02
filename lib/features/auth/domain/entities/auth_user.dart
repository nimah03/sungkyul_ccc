import 'package:flutter/foundation.dart';

/// 로그인한 사용자 도메인 엔티티.
///
/// 기존 CCC 앱의 프로필 모델 중 앱 셸 렌더링에 필요한 최소 필드만 담는다.
/// (전체 프로필/뱃지 등은 각 feature에서 별도 모델로 확장한다.)
@immutable
class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.cccUserid,
    this.isSoonjang = false,
  });

  /// 내부 사용자 식별자 (Supabase auth user id).
  final String id;

  /// 표시 이름 (예: "이하민").
  final String name;

  /// CCC 로그인 아이디.
  final String cccUserid;

  /// 순장 여부. 홈 환영 문구·순장 전용 메뉴 노출에 사용.
  final bool isSoonjang;

  /// 이름 뒤 호칭 포함 표시명 (예: "이하민 순장").
  String get displayTitle => isSoonjang ? '$name 순장' : name;
}
