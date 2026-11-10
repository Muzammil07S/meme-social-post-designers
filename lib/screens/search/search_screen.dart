// PERSON 3: Search Designs
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const _all = [
    Design(id: 1, title: 'First meme', text: 'When code works'),
    Design(id: 2, title: 'Birthday post', text: 'Happy Birthday!'),
    Design(id: 3, title: 'Quote', text: 'Keep going'),
  ];
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final results = _all
        .where((d) => d.title.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search designs'),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(child: Text('No results'))
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, i) => ListTile(
                      title: Text(results[i].title),
                      subtitle: Text(results[i].text),
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.designDetail,
                          arguments: results[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
