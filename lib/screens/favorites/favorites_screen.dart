// PERSON 3: Favorites
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<Design> _items = [
    const Design(id: 1, title: 'First meme', text: 'When code works'),
    const Design(id: 3, title: 'Quote', text: 'Keep going'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: _items.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, i) {
                final d = _items[i];
                return ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: Text(d.title),
                  subtitle: Text(d.text),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() => _items.removeAt(i)),
                  ),
                  onTap: () => Navigator.pushNamed(
                      context, AppRoutes.designDetail,
                      arguments: d),
                );
              },
            ),
    );
  }
}
