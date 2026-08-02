import 'package:sungkyul_ccc/features/auth/domain/entities/auth_user.dart';

/// 인증 저장소 계약(interface).
///
/// presentation/controller 는 이 추상 타입에만 의존하고,
/// 실제 구현(mock ↔ Supabase)은 data 계층에서 주입 교체한다.
abstract interface class AuthRepository {
  /// 저장된 세션이 있으면 사용자를, 없으면 null 을 돌려준다.
  Future<AuthUser?> currentUser();

  /// CCC 아이디/비밀번호로 로그인. 실패 시 [AuthException] 을 던진다.
  Future<AuthUser> login({required String userid, required String password});

  /// 로그아웃 (세션 파기).
  Future<void> logout();
}

/// 인증 과정에서 발생하는 사용자 표시용 예외.
class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
