import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';

class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> {
  final _searchController = TextEditingController();
  int _chipIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _tap(String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label yakında')),
    );
  }

  void _goBreathingExercise() => context.push('/breathing-exercise');
  void _goOverthink() => context.push('/overthink');
  void _goWhiteNoise() => context.push('/white-noise');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final horizontal = (size.width * 0.06).clamp(16.0, 22.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryLight, AppColors.background],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(horizontal, 14, horizontal, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _TopBar(),
                const SizedBox(height: 16),
                const Text(
                  'Neye ihtiyacın var?',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Zihnini dinlendirmek için bir kategori seç.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                _SearchField(controller: _searchController),
                const SizedBox(height: 14),
                _HeroCard(onTap: () => _tap('Derin Uyku Yolculuğu')),
                const SizedBox(height: 14),
                _CategoryGrid(
                  onBreath: _goBreathingExercise,
                  onMeditation: _goBreathingExercise,
                  onNoise: _goWhiteNoise,
                  onOverthink: _goOverthink,
                ),
                const SizedBox(height: 18),
                const Text(
                  'NASIL HİSSEDİYORSUN?',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _MoodChip(
                        text: 'Kaygılı',
                        selected: _chipIndex == 0,
                        onTap: () => setState(() => _chipIndex = 0),
                      ),
                      const SizedBox(width: 10),
                      _MoodChip(
                        text: 'Yorgun',
                        selected: _chipIndex == 1,
                        onTap: () => setState(() => _chipIndex = 1),
                      ),
                      const SizedBox(width: 10),
                      _MoodChip(
                        text: 'Mutlu',
                        selected: _chipIndex == 2,
                        onTap: () => setState(() => _chipIndex = 2),
                      ),
                      const SizedBox(width: 10),
                      _MoodChip(
                        text: 'Düşünceli',
                        selected: _chipIndex == 3,
                        onTap: () => setState(() => _chipIndex = 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.textMuted.withValues(alpha: 0.25)),
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        const Text(
          'Keşfet',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        const Spacer(),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.textMuted.withValues(alpha: 0.25)),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.textMuted.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: AppColors.textMuted.withValues(alpha: 0.9)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Egzersiz veya ses ara...',
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFCADFD7),
                Color(0xFF617C73),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.08),
                blurRadius: 22,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Opacity(
                  opacity: 0.18,
                  child: Icon(
                    Icons.nightlight_round,
                    size: 120,
                    color: AppColors.surface,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'YENİ',
                      style: TextStyle(
                        color: AppColors.surface,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Derin Uyku Yolculuğu',
                    style: TextStyle(
                      color: AppColors.surface,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Bu gece için özel rehberli meditasyon',
                    style: TextStyle(
                      color: AppColors.surface.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({
    required this.onBreath,
    required this.onMeditation,
    required this.onNoise,
    required this.onOverthink,
  });

  final VoidCallback onBreath;
  final VoidCallback onMeditation;
  final VoidCallback onNoise;
  final VoidCallback onOverthink;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.25,
      ),
      children: [
        _CategoryCard(
          title: 'Nefes\nEgzersizleri',
          subtitle: 'Zihnini hemen\nsakinleştir',
          icon: Icons.air_rounded,
          color: const Color(0xFFD6F8F4),
          onTap: onBreath,
        ),
        _CategoryCard(
          title: 'Meditasyon',
          subtitle: 'İç huzurunu\nkeşfet',
          icon: Icons.self_improvement_rounded,
          color: const Color(0xFFC5E7EA),
          onTap: onMeditation,
        ),
        _CategoryCard(
          title: 'Beyaz Gürültü',
          subtitle: 'Odaklan veya uyu',
          icon: Icons.waves_rounded,
          color: const Color(0xFFE8F2FF),
          onTap: onNoise,
        ),
        _CategoryCard(
          title: 'Overthink Köşesi',
          subtitle: 'Düşünce\ndöngüsünü kır',
          icon: Icons.psychology_alt_rounded,
          color: const Color(0xFFFFF4E6),
          onTap: onOverthink,
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.05),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: AppColors.primary),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoodChip extends StatelessWidget {
  const _MoodChip({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.primaryLight : AppColors.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.textMuted.withValues(alpha: 0.22),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: selected ? AppColors.primary : AppColors.textSecondary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
