import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/gemini_provider.dart';

class AiChatPage extends ConsumerWidget {
  const AiChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(geminiModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('AI Analiz / Sohbet')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              model == null
                  ? 'Gemini API anahtarı bulunamadı. GEMINI_API_KEY değerini --dart-define ile verin.'
                  : 'Gemini hazır. Sohbet ve analiz ekranları burada olacak.',
            ),
          ],
        ),
      ),
    );
  }
}
