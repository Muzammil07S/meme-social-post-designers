// PERSON 3: Favorites
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  static final List<Design> favorites = [
    const Design(id: 1, title: 'First meme', text: 'When code works'),
    const Design(id: 3, title: 'Quote', text: 'Keep going'),
  ];

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FavoritesScreen.favorites.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No favorite designs yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: FavoritesScreen.favorites.length,
              itemBuilder: (context, i) {
                final d = FavoritesScreen.favorites[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.red),
                    title: Text(d.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(d.text, maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => setState(() => FavoritesScreen.favorites.removeAt(i)),
                    ),
                    onTap: () async {
                      await Navigator.pushNamed(context, AppRoutes.designDetail,
                          arguments: d);
                      setState(() {});
                    },
                  ),
                );
              },
            ),
    );
  }
}
