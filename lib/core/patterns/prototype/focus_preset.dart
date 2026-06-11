import 'package:flutter/material.dart';

abstract interface class Prototype<T> {
  T clone();
}

final class FocusPreset implements Prototype<FocusPreset> {
  const FocusPreset({
    required this.name,
    required this.workMinutes,
    required this.breakMinutes,
    required this.description,
    required this.icon,
  });

  final String name;
  final int workMinutes;
  final int breakMinutes;
  final String description;
  final IconData icon;

  @override
  FocusPreset clone() {
    return FocusPreset(
      name: name,
      workMinutes: workMinutes,
      breakMinutes: breakMinutes,
      description: description,
      icon: icon,
    );
  }

  FocusPreset copyWith({
    String? name,
    int? workMinutes,
    int? breakMinutes,
    String? description,
    IconData? icon,
  }) {
    return FocusPreset(
      name: name ?? this.name,
      workMinutes: workMinutes ?? this.workMinutes,
      breakMinutes: breakMinutes ?? this.breakMinutes,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }
}

final class FocusPresetCatalog {
  static const List<FocusPreset> presets = [
    FocusPreset(
      name: 'Derin Odak',
      workMinutes: 25,
      breakMinutes: 5,
      description: 'Klasik Pomodoro dengesi',
      icon: Icons.timer_rounded,
    ),
    FocusPreset(
      name: 'Uzun Seans',
      workMinutes: 50,
      breakMinutes: 10,
      description: 'Daha uzun çalışma blokları',
      icon: Icons.hourglass_bottom_rounded,
    ),
    FocusPreset(
      name: 'Yumuşak Başlangıç',
      workMinutes: 15,
      breakMinutes: 5,
      description: 'Kısa ve düşük eforlu başlangıç',
      icon: Icons.spa_rounded,
    ),
  ];

  static List<FocusPreset> cloneCatalog() {
    return presets.map((preset) => preset.clone()).toList(growable: false);
  }
}