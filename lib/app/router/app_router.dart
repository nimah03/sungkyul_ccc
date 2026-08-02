import 'package:go_router/go_router.dart';
import 'package:sungkyul_ccc/features/auth/presentation/screens/login_screen.dart';
import 'package:sungkyul_ccc/features/auth/presentation/screens/splash_screen.dart';
import 'package:sungkyul_ccc/features/home/presentation/home_shell.dart';

/// 앱 라우트 경로 상수. 문자열을 화면마다 하드코딩하지 않도록 모아둔다.
abstract final class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
}

/// 앱 라우팅 설정 (go_router).
///
/// 진입점은 스플래시(`/`)이며, 스플래시가 세션을 확인한 뒤
/// 로그인 또는 홈으로 이동시킨다. 각 feature 라우트(/qt, /prayer 등)는
/// 해당 Phase에서 이곳에 추가한다.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeShell(),
    ),
  ],
);
