import 'package:flutter/material.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Uyku Alarmı')),
      body: const Center(
        child: Text('Yerel bildirim tabanlı alarm burada olacak.'),
      ),
    );
  }
}
