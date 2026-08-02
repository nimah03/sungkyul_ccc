import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sungkyul_ccc/features/auth/domain/entities/auth_user.dart';
import 'package:sungkyul_ccc/features/auth/presentation/providers/auth_providers.dart';

/// 현재 로그인 사용자 상태를 관리하는 컨트롤러.
///
/// - [build] : 앱 시작 시 저장된 세션을 조회한다(현재 mock 은 null).
/// - [login] / [logout] : 상태를 [AsyncValue] 로 갱신해 화면이 로딩/에러/성공을
///   선언적으로 처리하도록 한다.
class AuthController extends AsyncNotifier<AuthUser?> {
  @override
  Future<AuthUser?> build() {
    return ref.read(authRepositoryProvider).currentUser();
  }

  Future<void> login({required String userid, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .login(userid: userid, password: password),
    );
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncValue.data(null);
  }
}

/// 앱 전역 인증 상태 provider.
final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthUser?>(AuthController.new);
