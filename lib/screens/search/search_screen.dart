// PERSON 3: Search Designs in SQLite Database
import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';
  List<Design> _results = [];
  bool _isLoading = false;

  void _search(String query) async {
    setState(() {
      _query = query;
      _isLoading = true;
    });
    final res = await DatabaseHelper.instance.searchDesigns(query);
    setState(() {
      _results = res;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _search('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Database')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search database designs'),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _results.isEmpty
                    ? const Center(child: Text('No matching designs found in database'))
                    : ListView.builder(
                        itemCount: _results.length,
                        itemBuilder: (context, i) => ListTile(
                          leading: const Icon(Icons.storage, color: Colors.deepPurple),
                          title: Text(_results[i].title),
                          subtitle: Text(_results[i].text),
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.designDetail,
                              arguments: _results[i]),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
