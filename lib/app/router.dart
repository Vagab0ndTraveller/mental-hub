import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/ai_chat/presentation/ai_chat_page.dart';
import '../features/alarm/presentation/alarm_page.dart';
import '../features/auth/presentation/sign_in_page.dart';
import '../features/auth/presentation/sign_up_page.dart';
import '../features/breathing/presentation/breathing_page.dart';
import '../features/breathing/presentation/breathing_exercise_page.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/dashboard/presentation/daily_page.dart';
import '../features/dashboard/presentation/focus_hub_page.dart';
import '../features/dashboard/presentation/profile_account_page.dart';
import '../features/dashboard/presentation/profile_notifications_page.dart';
import '../features/dashboard/presentation/profile_page.dart';
import '../features/dashboard/presentation/profile_privacy_page.dart';
import '../features/dashboard/presentation/profile_rate_page.dart';
import '../features/mood_tracking/presentation/mood_page.dart';
import '../features/pomodoro/presentation/pomodoro_page.dart';
import '../features/onboarding/presentation/onboarding_page.dart';
import '../features/sleep_tracking/presentation/sleep_page.dart';
import '../features/splash/presentation/splash_page.dart';
import '../features/breathing/presentation/overthink_corner_page.dart';
import '../features/white_noise/presentation/white_noise_page.dart';
import 'shell.dart';

CustomTransitionPage<void> _defaultPage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 260),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.06, 0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            _defaultPage(state, const SplashPage()),
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) =>
            _defaultPage(state, const OnboardingPage()),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            _defaultPage(state, const SignInPage()),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) =>
            _defaultPage(state, const SignUpPage()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: DashboardPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/daily',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: DailyPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/discover',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: BreathingPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/focus',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: FocusHubPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfilePage()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/sleep',
        pageBuilder: (context, state) => _defaultPage(state, const SleepPage()),
      ),
      GoRoute(
        path: '/breathing',
        redirect: (context, state) => '/discover',
      ),
      GoRoute(
        path: '/breathing-exercise',
        pageBuilder: (context, state) =>
            _defaultPage(state, const BreathingExercisePage()),
      ),
      GoRoute(
        path: '/overthink',
        pageBuilder: (context, state) =>
            _defaultPage(state, const OverthinkCornerPage()),
      ),
      GoRoute(
        path: '/white-noise',
        pageBuilder: (context, state) =>
            _defaultPage(state, const WhiteNoisePage()),
      ),
      GoRoute(
        path: '/profile/notifications',
        pageBuilder: (context, state) =>
            _defaultPage(state, const ProfileNotificationsPage()),
      ),
      GoRoute(
        path: '/profile/account',
        pageBuilder: (context, state) =>
            _defaultPage(state, const ProfileAccountPage()),
      ),
      GoRoute(
        path: '/profile/privacy',
        pageBuilder: (context, state) =>
            _defaultPage(state, const ProfilePrivacyPage()),
      ),
      GoRoute(
        path: '/profile/rate',
        pageBuilder: (context, state) =>
            _defaultPage(state, const ProfileRatePage()),
      ),
      GoRoute(
        path: '/mood',
        pageBuilder: (context, state) => _defaultPage(state, const MoodPage()),
      ),
      GoRoute(
        path: '/pomodoro',
        pageBuilder: (context, state) =>
            _defaultPage(state, const PomodoroPage()),
      ),
      GoRoute(
        path: '/alarm',
        pageBuilder: (context, state) => _defaultPage(state, const AlarmPage()),
      ),
      GoRoute(
        path: '/ai',
        pageBuilder: (context, state) => _defaultPage(state, const AiChatPage()),
      ),
    ],
  );
});
