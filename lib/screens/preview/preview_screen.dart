// PERSON 2: Preview / Export
import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final text = (args?['text'] as String?) ?? '';
    final size = (args?['size'] as double?) ?? 28;
    final color = (args?['color'] as Color?) ?? Colors.white;
    final bg = (args?['bg'] as Color?) ?? Colors.deepPurple;

    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: bg,
                alignment: Alignment.center,
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: size, color: color)),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save Design'),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Saved (database baad mein)'))),
            ),
          ],
        ),
      ),
    );
  }
}
