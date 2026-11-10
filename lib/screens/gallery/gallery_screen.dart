// PERSON 2: Template Gallery (GridView)
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  static const List<Map<String, Object>> _templates = [
    {'name': 'Classic Meme', 'color': Colors.orange},
    {'name': 'Quote Post', 'color': Colors.teal},
    {'name': 'Birthday', 'color': Colors.pink},
    {'name': 'Motivation', 'color': Colors.indigo},
    {'name': 'Sale Banner', 'color': Colors.red},
    {'name': 'Plain', 'color': Colors.blueGrey},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: _templates.length,
      itemBuilder: (context, i) {
        final t = _templates[i];
        return InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.editor,
              arguments: {'name': t['name'], 'color': t['color']}),
          child: Card(
            color: t['color'] as Color,
            child: Center(
              child: Text(t['name'] as String,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        );
      },
    );
  }
}
