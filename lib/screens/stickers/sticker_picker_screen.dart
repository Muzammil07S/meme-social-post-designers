// PERSON 2: Sticker / Text Style Picker
import 'package:flutter/material.dart';

class StickerPickerScreen extends StatelessWidget {
  const StickerPickerScreen({super.key});

  static const _stickers = [
    '😂', '😎', '🔥', '❤️', '👍', '😭', '🤔', '🎉', '💀', '🙌', '😍', '🥳',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stickers')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemCount: _stickers.length,
        itemBuilder: (context, i) => InkWell(
          // Editor ko selected sticker wapas bhejta hai
          onTap: () => Navigator.pop(context, _stickers[i]),
          child: Card(
            child: Center(
                child: Text(_stickers[i], style: const TextStyle(fontSize: 36))),
          ),
        ),
      ),
    );
  }
}
