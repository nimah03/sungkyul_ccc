import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sungkyul_ccc/app/router/app_router.dart';
import 'package:sungkyul_ccc/core/theme/app_colors.dart';
import 'package:sungkyul_ccc/core/theme/app_spacing.dart';
import 'package:sungkyul_ccc/features/auth/domain/repositories/auth_repository.dart';
import 'package:sungkyul_ccc/features/auth/presentation/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

/// 로그인 화면 — Canva 로그인 시안.
///
/// 로고+태그라인 → Welcome 안내 → (아이디/비밀번호 입력 + 로그인 버튼) 카드 →
/// 회원가입 안내 순으로 구성한다. 인증 로직은 [AuthController] 에 위임한다.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  static const _signupUrl = 'https://www.kccc.org/login';

  final _useridController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _useridController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    await ref.read(authControllerProvider.notifier).login(
          userid: _useridController.text,
          password: _passwordController.text,
        );
  }

  Future<void> _openSignup() async {
    final uri = Uri.parse(_signupUrl);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Object {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('페이지를 열 수 없습니다.')),
      );
    }
  }

  String? _errorText(Object error) =>
      error is AuthException ? error.message : '로그인 중 오류가 발생했습니다.';

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;
    final errorText = authState.hasError ? _errorText(authState.error!) : null;

    // 로그인 성공(사용자 존재) 시 홈으로 이동.
    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasValue && next.value != null) {
        context.go(AppRoutes.home);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Image.asset('assets/branding/logo.png'),
              ),
              const SizedBox(height: AppSpacing.xl),
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                '성결대 CCC 아이디로 로그인 해주세요!',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _LoginCard(
                useridController: _useridController,
                passwordController: _passwordController,
                obscure: _obscure,
                onToggleObscure: () => setState(() => _obscure = !_obscure),
                isLoading: isLoading,
                errorText: errorText,
                onSubmit: _submit,
              ),
              const SizedBox(height: AppSpacing.lg),
              _SignupRow(onTap: _openSignup),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

/// 아이디/비밀번호 입력과 로그인 버튼을 담는 크림색 카드.
class _LoginCard extends StatelessWidget {
  const _LoginCard({
    required this.useridController,
    required this.passwordController,
    required this.obscure,
    required this.onToggleObscure,
    required this.isLoading,
    required this.errorText,
    required this.onSubmit,
  });

  final TextEditingController useridController;
  final TextEditingController passwordController;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final bool isLoading;
  final String? errorText;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Column(
        children: [
          if (errorText != null) ...[
            _ErrorBox(message: errorText!),
            const SizedBox(height: AppSpacing.sm),
          ],
          TextField(
            controller: useridController,
            enabled: !isLoading,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: '아이디',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: passwordController,
            enabled: !isLoading,
            obscureText: obscure,
            autocorrect: false,
            enableSuggestions: false,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => onSubmit(),
            decoration: InputDecoration(
              hintText: '비밀번호',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: onToggleObscure,
                icon: Icon(
                  obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: isLoading ? null : onSubmit,
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: Colors.white,
                    ),
                  )
                : const Text('로그인'),
          ),
        ],
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, size: 18, color: AppColors.error),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: AppColors.error, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignupRow extends StatelessWidget {
  const _SignupRow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '아이디가 없으신가요? ',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            '회원가입 하러가기',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryDark,
            ),
          ),
        ),
      ],
    );
  }
}
