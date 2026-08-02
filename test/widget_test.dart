import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sungkyul_ccc/features/auth/presentation/controllers/auth_controller.dart';

void main() {
  group('AuthController (mock)', () {
    test('초기 상태는 로그인 사용자가 없다', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final user = await container.read(authControllerProvider.future);
      expect(user, isNull);
    });

    test('유효한 아이디/비밀번호로 로그인하면 사용자가 설정된다', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container
          .read(authControllerProvider.notifier)
          .login(userid: 'sku123', password: 'pw');

      final state = container.read(authControllerProvider);
      expect(state.hasValue, isTrue);
      expect(state.value?.name, '이하민');
      expect(state.value?.isSoonjang, isTrue);
    });

    test('빈 입력으로 로그인하면 에러 상태가 된다', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container
          .read(authControllerProvider.notifier)
          .login(userid: '', password: '');

      final state = container.read(authControllerProvider);
      expect(state.hasError, isTrue);
    });
  });
}
