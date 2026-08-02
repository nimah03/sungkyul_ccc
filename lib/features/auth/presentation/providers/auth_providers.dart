import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sungkyul_ccc/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:sungkyul_ccc/features/auth/domain/repositories/auth_repository.dart';

/// 인증 저장소 provider.
///
/// 현재는 [MockAuthRepository] 를 제공한다. Supabase 연동 시 이 한 줄만
/// 교체하면 앱 전체가 실 서버 인증으로 전환된다.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => MockAuthRepository(),
);
