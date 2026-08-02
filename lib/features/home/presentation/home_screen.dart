import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sungkyul_ccc/core/theme/app_colors.dart';
import 'package:sungkyul_ccc/core/theme/app_spacing.dart';
import 'package:sungkyul_ccc/features/auth/presentation/controllers/auth_controller.dart';

/// 홈 탭 본문 — Canva 홈 시안.
///
/// 상단바(로고·공지·알림) → 환영 카드 → "나의 기록" → "CCC 일정"(월 달력) 순서.
/// 각 기록 진입은 해당 Phase에서 실제 화면과 연결한다(현재는 준비중 안내).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    final title = user?.displayTitle ?? '순장';

    return Column(
      children: [
        const _HomeTopBar(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.xl,
            ),
            children: [
              _WelcomeCard(name: title),
              const SizedBox(height: AppSpacing.lg),
              const _SectionHeader(
                icon: Icons.bookmark_border,
                label: '나의 기록',
              ),
              const SizedBox(height: AppSpacing.sm),
              const _RecordsCard(),
              const SizedBox(height: AppSpacing.lg),
              const _SectionHeader(
                icon: Icons.calendar_today_outlined,
                label: 'CCC 일정',
              ),
              const SizedBox(height: AppSpacing.sm),
              const _ScheduleCard(),
            ],
          ),
        ),
      ],
    );
  }
}

/// 상단바: 로고 마크 + 공지 텍스트 + 알림 벨.
class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.sm,
        ),
        child: Row(
          children: [
            Image.asset('assets/branding/logo_mark.png', height: 26),
            const SizedBox(width: AppSpacing.sm),
            const Icon(
              Icons.volume_up_outlined,
              size: 18,
              color: AppColors.accentPurple,
            ),
            const SizedBox(width: AppSpacing.xs),
            const Expanded(
              child: Text(
                '공지사항~~~~',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            IconButton(
              onPressed: () => _comingSoon(context, '알림'),
              icon: const Icon(Icons.notifications_none),
              color: AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}

/// "OO 순장님, 환영합니다!" 환영 카드.
class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name님, 환영합니다!',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const _JeopsunBadge(),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Grafting Campus to the Cross',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                const Text(
                  '모든 학과를 십자가에 접붙여 캠퍼스에 생명 운동을 일으키자',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  child: Image.asset(
                    'assets/branding/welcome_illust.png',
                    height: 96,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 퍼플 "접순" 라벨.
class _JeopsunBadge extends StatelessWidget {
  const _JeopsunBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentPurple.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: const Text(
        '접순',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: AppColors.accentPurple,
        ),
      ),
    );
  }
}

/// 아이콘 + 라벨의 섹션 제목.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textPrimary),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// "나의 기록" — QT / 기도 노트 / 전도 노트 pill 3개.
class _RecordsCard extends StatelessWidget {
  const _RecordsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentCyan,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Row(
        children: [
          _RecordPill(label: 'QT', onTap: () => _comingSoon(context, 'QT')),
          const SizedBox(width: AppSpacing.sm),
          _RecordPill(
            label: '기도 노트',
            onTap: () => _comingSoon(context, '기도 노트'),
          ),
          const SizedBox(width: AppSpacing.sm),
          _RecordPill(
            label: '전도 노트',
            onTap: () => _comingSoon(context, '전도 노트'),
          ),
        ],
      ),
    );
  }
}

class _RecordPill extends StatelessWidget {
  const _RecordPill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "CCC 일정" — 이번 달 달력.
class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.accentCyan,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${now.month}월',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radius),
            ),
            child: _MonthCalendar(month: now),
          ),
        ],
      ),
    );
  }
}

/// 월 단위 달력 그리드 (일요일 시작, 오늘 강조).
class _MonthCalendar extends StatelessWidget {
  const _MonthCalendar({required this.month});

  final DateTime month;

  static const _weekdayLabels = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final first = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    // weekday: 월=1..일=7 → 일요일 시작 그리드로 변환.
    final leading = first.weekday % 7;
    final gridStart = first.subtract(Duration(days: leading));
    final rows = ((leading + daysInMonth) / 7).ceil();

    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < 7; i++)
              Expanded(
                child: Center(
                  child: Text(
                    _weekdayLabels[i],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _weekdayColor(i),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        for (var r = 0; r < rows; r++)
          Row(
            children: [
              for (var c = 0; c < 7; c++)
                _DayCell(
                  date: gridStart.add(Duration(days: r * 7 + c)),
                  month: month,
                  today: today,
                ),
            ],
          ),
      ],
    );
  }

  Color _weekdayColor(int index) {
    if (index == 0) return AppColors.error;
    if (index == 6) return AppColors.primaryDark;
    return AppColors.textSecondary;
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.month,
    required this.today,
  });

  final DateTime date;
  final DateTime month;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final inMonth = date.month == month.month;
    final isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    final Color textColor;
    if (isToday) {
      textColor = Colors.white;
    } else if (!inMonth) {
      textColor = AppColors.textSecondary.withValues(alpha: 0.4);
    } else {
      textColor = AppColors.textPrimary;
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: isToday
                ? const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  )
                : null,
            child: Text(
              '${date.day}',
              style: TextStyle(fontSize: 12, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}

/// 미구현 기능 진입 시 임시 안내.
void _comingSoon(BuildContext context, String name) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('$name 기능은 준비 중입니다.')),
  );
}
