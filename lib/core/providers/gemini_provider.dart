import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final geminiModelProvider = Provider<GenerativeModel?>((ref) {
  final apiKey = const String.fromEnvironment('GEMINI_API_KEY');
  if (apiKey.isEmpty) return null;

  return GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
  );
});
