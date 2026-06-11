import 'dart:collection';

import 'package:flutter/foundation.dart';

enum JournalEntryKind { mood, sleep }

@immutable
class WellbeingEntry {
  const WellbeingEntry({
    required this.kind,
    required this.primaryIndex,
    required this.stressLevel,
    required this.note,
    required this.recordedAt,
  });

  final JournalEntryKind kind;
  final int primaryIndex;
  final double stressLevel;
  final String note;
  final DateTime recordedAt;
}

final class MoodJournalStore extends ChangeNotifier {
  static const List<String> moodLabels = [
    'Neşeli',
    'Sakin',
    'Dingin',
    'Üzgün',
    'Kırılgan',
    'Gergin',
    'Öfkeli',
    'Rahat',
    'Uykulu',
    'Enerjik',
  ];

  static const List<String> sleepLabels = [
    'Çok İyi',
    'İyi',
    'Orta',
    'Kötü',
    'Zor',
  ];

  final List<WellbeingEntry> _entries = [];

  UnmodifiableListView<WellbeingEntry> get entries =>
      UnmodifiableListView(_entries);

  WellbeingEntry? get latestEntry =>
      _entries.isEmpty ? null : _entries.last;

  int get totalEntries => _entries.length;

  int get moodEntryCount =>
      _entries.where((entry) => entry.kind == JournalEntryKind.mood).length;

  int get sleepEntryCount =>
      _entries.where((entry) => entry.kind == JournalEntryKind.sleep).length;

  double get averageStress {
    if (_entries.isEmpty) return 0;
    final total = _entries.fold<double>(0, (sum, entry) => sum + entry.stressLevel);
    return total / _entries.length;
  }

  void recordMoodCheckIn({
    required int moodIndex,
    required double stressLevel,
    required String note,
  }) {
    _recordEntry(
      kind: JournalEntryKind.mood,
      primaryIndex: moodIndex,
      stressLevel: stressLevel,
      note: note,
    );
  }

  void recordSleepCheckIn({
    required int sleepIndex,
    required double stressLevel,
    required String note,
  }) {
    _recordEntry(
      kind: JournalEntryKind.sleep,
      primaryIndex: sleepIndex,
      stressLevel: stressLevel,
      note: note,
    );
  }

  String labelForEntry(WellbeingEntry entry) {
    final labels = entry.kind == JournalEntryKind.mood
        ? moodLabels
        : sleepLabels;
    final safeIndex = entry.primaryIndex.clamp(0, labels.length - 1);
    return labels[safeIndex];
  }

  String latestEntrySummary() {
    final latest = latestEntry;
    if (latest == null) return 'Henüz kayıt yok';
    final label = labelForEntry(latest);
    final kindLabel = latest.kind == JournalEntryKind.mood ? 'Ruh hali' : 'Uyku';
    return '$kindLabel: $label';
  }

  void _recordEntry({
    required JournalEntryKind kind,
    required int primaryIndex,
    required double stressLevel,
    required String note,
  }) {
    _entries.add(
      WellbeingEntry(
        kind: kind,
        primaryIndex: primaryIndex,
        stressLevel: stressLevel,
        note: note.trim(),
        recordedAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}