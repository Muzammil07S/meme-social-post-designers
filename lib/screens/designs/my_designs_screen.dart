// PERSON 3: My Designs (ListView). Baad mein Drift SQLite se connect karna.
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';

class MyDesignsScreen extends StatelessWidget {
  const MyDesignsScreen({super.key});

  static const _dummy = [
    Design(id: 1, title: 'First meme', text: 'When code works'),
    Design(id: 2, title: 'Birthday post', text: 'Happy Birthday!'),
    Design(id: 3, title: 'Quote', text: 'Keep going'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _dummy.length,
      itemBuilder: (context, i) {
        final d = _dummy[i];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.image),
            title: Text(d.title),
            subtitle: Text(d.text),
            onTap: () => Navigator.pushNamed(context, AppRoutes.designDetail,
                arguments: d),
          ),
        );
      },
    );
  }
}
