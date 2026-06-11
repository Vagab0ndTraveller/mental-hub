import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mood_journal_store.dart';

final moodJournalProvider = ChangeNotifierProvider<MoodJournalStore>((ref) {
  return MoodJournalStore();
});