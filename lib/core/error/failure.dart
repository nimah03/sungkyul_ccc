/// 도메인 계층에서 다루는 실패(에러) 표현.
///
/// data 계층에서 발생한 예외(Exception)를 이 타입으로 변환해 올려보내,
/// presentation 계층이 사용자 친화적으로 처리하도록 한다.
sealed class Failure {
  const Failure(this.message);

  final String message;
}

/// 서버/DB 응답 오류 (Supabase PostgrestException 등).
final class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// 네트워크 연결 실패.
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// 인증/권한 오류 (미로그인, 세션 만료 등).
final class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// 분류되지 않은 예기치 못한 오류.
final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = '알 수 없는 오류가 발생했습니다.']);
}
