import 'package:sungkyul_ccc/features/auth/domain/entities/auth_user.dart';
import 'package:sungkyul_ccc/features/auth/domain/repositories/auth_repository.dart';

/// Supabase 연결 전 임시 인증 구현.
///
/// 비어있지 않은 아이디/비밀번호면 로그인 성공 처리하고 데모 사용자를 돌려준다.
/// 실제 연동 단계에서 기존 CCC 로그인(edge function `ccc-login`)을 호출하는
/// `SupabaseAuthRepository` 로 교체한다. (컨트롤러/화면은 수정 불필요)
class MockAuthRepository implements AuthRepository {
  AuthUser? _current;

  @override
  Future<AuthUser?> currentUser() async => _current;

  @override
  Future<AuthUser> login({
    required String userid,
    required String password,
  }) async {
    // 네트워크 호출을 흉내 내기 위한 짧은 지연.
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (userid.trim().isEmpty || password.isEmpty) {
      throw const AuthException('아이디와 비밀번호를 입력해주세요.');
    }

    _current = AuthUser(
      id: 'mock-user',
      name: '이하민',
      cccUserid: userid.trim(),
      isSoonjang: true,
    );
    return _current!;
  }

  @override
  Future<void> logout() async {
    _current = null;
  }
}
