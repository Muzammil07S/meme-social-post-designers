// PERSON 3: My Designs (ListView)
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';

class MyDesignsScreen extends StatefulWidget {
  const MyDesignsScreen({super.key});

  static final List<Design> designs = [
    const Design(id: 1, title: 'First meme', text: 'When code works'),
    const Design(id: 2, title: 'Birthday post', text: 'Happy Birthday!'),
    const Design(id: 3, title: 'Quote', text: 'Keep going'),
  ];

  @override
  State<MyDesignsScreen> createState() => _MyDesignsScreenState();
}

class _MyDesignsScreenState extends State<MyDesignsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyDesignsScreen.designs.isEmpty
          ? const Center(child: Text('No designs saved yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: MyDesignsScreen.designs.length,
              itemBuilder: (context, i) {
                final d = MyDesignsScreen.designs[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.image, color: Colors.deepPurple),
                    title: Text(d.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(d.text, maxLines: 1, overflow: TextOverflow.ellipsis),
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
