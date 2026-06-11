# Mental-Sleep Hub

Türkçe uyku ve ruh sağlığı takip uygulaması.

## Tasarım Şablonları

Projede sunumda anlatılabilir şekilde aşağıdaki yapılar entegre edildi:

- Observer: [MoodJournalStore](lib/core/patterns/observer/mood_journal_store.dart) ve Riverpod provider üzerinden günlük kayıtların ekranlar arasında canlı paylaşımı.
- Prototype: [FocusPreset](lib/core/patterns/prototype/focus_preset.dart) ile odak seansı preset’lerinin klonlanabilir yapıdan türetilmesi.
- Strategy: [RecommendationStrategy](lib/core/patterns/strategy/recommendation_strategy.dart) ile dashboard öneri metninin kayıt durumuna göre değişmesi.
- Factory: [RecommendationStrategyFactory](lib/core/patterns/strategy/recommendation_strategy.dart) ile uygun stratejinin seçilmesi.

## Demo Akışı

- Splash ve onboarding ile giriş deneyimi.
- Daily ekranında ruh hali veya uyku kaydı ekleme.
- Mood ekranında bu kayıtların canlı listelenmesi.
- Focus ekranında preset seçip seans parametrelerini anında değiştirme.
- Dashboard ekranında dinamik öneri kartı.

## Not

Bu proje bir başlangıç şablonu değil; ders sunumunda tasarım dili, pattern seçimi ve mimari kararları göstermek için yapılandırıldı.
