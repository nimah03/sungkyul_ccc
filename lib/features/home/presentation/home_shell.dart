import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sungkyul_ccc/app/router/app_router.dart';
import 'package:sungkyul_ccc/core/theme/app_colors.dart';
import 'package:sungkyul_ccc/core/theme/app_spacing.dart';
import 'package:sungkyul_ccc/features/auth/presentation/controllers/auth_controller.dart';
import 'package:sungkyul_ccc/features/home/presentation/home_screen.dart';

/// 로그인 이후의 앱 셸 — 하단 탭 네비게이션(홈·순장·순 소개·더보기).
///
/// 현재는 홈 탭만 실제 화면이며, 나머지는 각 Phase에서 채운다.
class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _index = 0;

  static const _tabs = <_TabSpec>[
    _TabSpec(icon: Icons.home_outlined, activeIcon: Icons.home, label: '홈'),
    _TabSpec(
      icon: Icons.church_outlined,
      activeIcon: Icons.church,
      label: '순장',
    ),
    _TabSpec(icon: Icons.eco_outlined, activeIcon: Icons.eco, label: '순 소개'),
    _TabSpec(
      icon: Icons.more_horiz,
      activeIcon: Icons.more_horiz,
      label: '더보기',
    ),
  ];

  Future<void> _logout() async {
    await ref.read(authControllerProvider.notifier).logout();
    if (!mounted) return;
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          const HomeScreen(),
          const _ComingSoonTab(label: '순장'),
          const _ComingSoonTab(label: '순 소개'),
          _MoreTab(onLogout: _logout),
        ],
      ),
      bottomNavigationBar: _BottomBar(
        tabs: _tabs,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _TabSpec {
  const _TabSpec({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

/// Canva 시안의 연녹색 하단 탭 바.
class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  final List<_TabSpec> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              for (var i = 0; i < tabs.length; i++)
                Expanded(
                  child: _BottomBarItem(
                    spec: tabs[i],
                    selected: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({
    required this.spec,
    required this.selected,
    required this.onTap,
  });

  final _TabSpec spec;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primaryDark : AppColors.textSecondary;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(selected ? spec.activeIcon : spec.icon, size: 24, color: color),
          const SizedBox(height: 3),
          Text(
            spec.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// 아직 구현되지 않은 탭 자리 표시자.
class _ComingSoonTab extends StatelessWidget {
  const _ComingSoonTab({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Center(
        child: Text(
          '$label 기능은 준비 중입니다.',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

/// "더보기" 탭 — 현재는 로그아웃만 제공.
class _MoreTab extends StatelessWidget {
  const _MoreTab({required this.onLogout});

  final Future<void> Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('더보기')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text('로그아웃'),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
