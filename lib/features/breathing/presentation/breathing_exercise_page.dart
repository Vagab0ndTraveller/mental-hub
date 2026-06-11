import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';

class BreathingExercisePage extends StatefulWidget {
  const BreathingExercisePage({super.key});

  @override
  State<BreathingExercisePage> createState() => _BreathingExercisePageState();
}

enum _Phase { inhale, hold, exhale }

class _BreathingExercisePageState extends State<BreathingExercisePage> {
  static const int inhaleSeconds = 4;
  static const int holdSeconds = 7;
  static const int exhaleSeconds = 8;

  Timer? _timer;
  bool _running = false;
  _Phase _phase = _Phase.inhale;
  int _remaining = inhaleSeconds;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggle() {
    if (_running) {
      _timer?.cancel();
      setState(() => _running = false);
      return;
    }

    setState(() => _running = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_remaining > 1) {
        setState(() => _remaining -= 1);
        return;
      }

      setState(() {
        switch (_phase) {
          case _Phase.inhale:
            _phase = _Phase.hold;
            _remaining = holdSeconds;
            break;
          case _Phase.hold:
            _phase = _Phase.exhale;
            _remaining = exhaleSeconds;
            break;
          case _Phase.exhale:
            _phase = _Phase.inhale;
            _remaining = inhaleSeconds;
            break;
        }
      });
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _running = false;
      _phase = _Phase.inhale;
      _remaining = inhaleSeconds;
    });
  }

  double get _phaseProgress {
    final total = switch (_phase) {
      _Phase.inhale => inhaleSeconds,
      _Phase.hold => holdSeconds,
      _Phase.exhale => exhaleSeconds,
    };
    return (total - _remaining) / total;
  }

  String get _phaseLabel {
    return switch (_phase) {
      _Phase.inhale => 'Nefes Al',
      _Phase.hold => 'Tut',
      _Phase.exhale => 'Ver',
    };
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final horizontal = (size.width * 0.06).clamp(16.0, 22.0);
    final circleSize = math.min(size.width * 0.74, 280.0);

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
                Row(
                  children: [
                    _IconButton(
                      icon: Icons.arrow_back_rounded,
                      onTap: () => context.pop(),
                    ),
                    const Spacer(),
                    const Text(
                      'Zihin Uyku',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    _IconButton(
                      icon: Icons.settings_rounded,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  '4-7-8 Nefes Tekniği',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Derin bir rahatlama ve uyku öncesi\nsakinlik için tasarlanmış ritmik nefes\negzersizi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    fontSize: (size.width * 0.04).clamp(13.0, 14.0),
                  ),
                ),
                const SizedBox(height: 22),
                Center(
                  child: SizedBox(
                    width: circleSize,
                    height: circleSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(alpha: 0.12),
                          ),
                        ),
                        SizedBox(
                          width: circleSize,
                          height: circleSize,
                          child: CircularProgressIndicator(
                            value: _running ? _phaseProgress : 0,
                            strokeWidth: 10,
                            backgroundColor:
                                AppColors.primaryLight.withValues(alpha: 0.8),
                            valueColor:
                                const AlwaysStoppedAnimation(AppColors.primary),
                          ),
                        ),
                        Container(
                          width: circleSize * 0.82,
                          height: circleSize * 0.82,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(alpha: 0.92),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.22),
                                blurRadius: 26,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _running ? _phaseLabel : 'Başlat',
                              style: const TextStyle(
                                color: AppColors.surface,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _running ? '$_remaining' : '--',
                              style: TextStyle(
                                color: AppColors.surface.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: const [
                    Expanded(
                      child: _PhaseTile(label: 'NEFES AL', seconds: '4s'),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: _PhaseTile(label: 'TUT', seconds: '7s')),
                    SizedBox(width: 10),
                    Expanded(child: _PhaseTile(label: 'VER', seconds: '8s')),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: _toggle,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.surface,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_running ? Icons.pause_rounded : Icons.play_arrow_rounded),
                        const SizedBox(width: 8),
                        Text(
                          _running ? 'Duraklat' : 'Egzersizi Başlat',
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (_running)
                  TextButton(
                    onPressed: _reset,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      textStyle: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    child: const Text('Sıfırla'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.textMuted.withValues(alpha: 0.25)),
          ),
          child: Icon(icon, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _PhaseTile extends StatelessWidget {
  const _PhaseTile({required this.label, required this.seconds});

  final String label;
  final String seconds;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w900,
              fontSize: 11,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            seconds,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

