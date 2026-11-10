// PERSON 3: Detail + delete dialog + favorite toggle
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../favorites/favorites_screen.dart';
import 'my_designs_screen.dart';

class DesignDetailScreen extends StatefulWidget {
  const DesignDetailScreen({super.key});

  @override
  State<DesignDetailScreen> createState() => _DesignDetailScreenState();
}

class _DesignDetailScreenState extends State<DesignDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final d = ModalRoute.of(context)?.settings.arguments as Design?;
    final isFav = FavoritesScreen.favorites.any((fav) => fav.id == d?.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(d?.title ?? 'Design'),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                if (isFav) {
                  FavoritesScreen.favorites.removeWhere((fav) => fav.id == d?.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Removed from favorites')),
                  );
                } else {
                  if (d != null) {
                    FavoritesScreen.favorites.add(d);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to favorites!')),
                    );
                  }
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmDelete(context, d),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(d?.text ?? '', textAlign: TextAlign.center, style: const TextStyle(fontSize: 28)),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Design? d) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete design?'),
        content: const Text('Yeh design hamesha ke liye delete ho jayega.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
              if (d != null) {
                MyDesignsScreen.designs.removeWhere((item) => item.id == d.id);
                FavoritesScreen.favorites.removeWhere((item) => item.id == d.id);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Design deleted')));
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
