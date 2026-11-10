// PERSON 2: Template Gallery (GridView with Icons/Pictures)
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  static const List<Map<String, Object>> _templates = [
    {'name': 'Classic Meme', 'color': Colors.orange, 'icon': Icons.emoji_emotions},
    {'name': 'Quote Post', 'color': Colors.teal, 'icon': Icons.format_quote},
    {'name': 'Birthday', 'color': Colors.pink, 'icon': Icons.cake},
    {'name': 'Motivation', 'color': Colors.indigo, 'icon': Icons.bolt},
    {'name': 'Sale Banner', 'color': Colors.red, 'icon': Icons.local_offer},
    {'name': 'Plain Post', 'color': Colors.blueGrey, 'icon': Icons.article},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.1),
      itemCount: _templates.length,
      itemBuilder: (context, i) {
        final t = _templates[i];
        return InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.editor,
              arguments: {'name': t['name'], 'color': t['color'], 'icon': t['icon']}),
          child: Card(
            color: t['color'] as Color,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(t['icon'] as IconData, size: 42, color: Colors.white),
                  const SizedBox(height: 12),
                  Text(
                    t['name'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
