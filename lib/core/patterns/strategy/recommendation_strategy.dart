import '../observer/mood_journal_store.dart';

final class RecommendationCardData {
  const RecommendationCardData({
    required this.badge,
    required this.title,
    required this.body,
    required this.actionLabel,
  });

  final String badge;
  final String title;
  final String body;
  final String actionLabel;
}

abstract interface class RecommendationStrategy {
  RecommendationCardData build(MoodJournalStore store);
}

final class FirstVisitStrategy implements RecommendationStrategy {
  const FirstVisitStrategy();

  @override
  RecommendationCardData build(MoodJournalStore store) {
    return const RecommendationCardData(
      badge: 'YENİ',
      title: 'İlk verini kaydet',
      body: 'Bir ruh hali veya uyku kaydı eklediğinde, analiz kartı otomatik olarak güncellenecek.',
      actionLabel: 'Kayıt Ekle',
    );
  }
}

final class RecoveryStrategy implements RecommendationStrategy {
  const RecoveryStrategy();

  @override
  RecommendationCardData build(MoodJournalStore store) {
    final latest = store.latestEntry;
    final latestLabel = latest == null ? 'son kayıt' : store.labelForEntry(latest);
    return RecommendationCardData(
      badge: 'DESTEK',
      title: 'Toparlanma odaklı bir gün',
      body: 'Ortalama stres ${store.averageStress.toStringAsFixed(1)} seviyesinde. $latestLabel sonrası kısa bir nefes egzersizi iyi gelebilir.',
      actionLabel: 'Nefes Aç',
    );
  }
}

final class MomentumStrategy implements RecommendationStrategy {
  const MomentumStrategy();

  @override
  RecommendationCardData build(MoodJournalStore store) {
    return RecommendationCardData(
      badge: 'İLERLE',
      title: 'Ritmini koruyorsun',
      body: 'Kayıt sayın ${store.totalEntries}. Düzenli girişlerin sayesinde haftalık trendleri daha net görebiliyorsun.',
      actionLabel: 'Analize Git',
    );
  }
}

final class SleepRecoveryStrategy implements RecommendationStrategy {
  const SleepRecoveryStrategy();

  @override
  RecommendationCardData build(MoodJournalStore store) {
    return const RecommendationCardData(
      badge: 'UYKU',
      title: 'Uyku ritmini güçlendir',
      body: 'Son kayıt uyku üzerine. Küçük bir mola ve sakin bir kapatma rutini gece geçişini kolaylaştırabilir.',
      actionLabel: 'Odak Aç',
    );
  }
}

final class RecommendationStrategyFactory {
  const RecommendationStrategyFactory._();

  static RecommendationStrategy resolve(MoodJournalStore store) {
    if (store.totalEntries == 0) {
      return const FirstVisitStrategy();
    }

    if (store.averageStress >= 7) {
      return const RecoveryStrategy();
    }

    final latest = store.latestEntry;
    if (latest?.kind == JournalEntryKind.sleep) {
      return const SleepRecoveryStrategy();
    }

    return const MomentumStrategy();
  }
}