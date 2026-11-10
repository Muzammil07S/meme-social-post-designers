// PERSON 2: Template Categories (TabBar + TabController)
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const _tabs = {
    'Memes': Colors.orange,
    'Quotes': Colors.teal,
    'Posts': Colors.indigo,
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          bottom: TabBar(tabs: _tabs.keys.map((k) => Tab(text: k)).toList()),
        ),
        body: TabBarView(
          children: _tabs.entries.map((e) {
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemCount: 6,
              itemBuilder: (context, i) => InkWell(
                onTap: () => Navigator.pushNamed(context, AppRoutes.editor,
                    arguments: {'name': '${e.key} ${i + 1}', 'color': e.value}),
                child: Card(
                  color: e.value,
                  child: Center(
                    child: Text('${e.key} ${i + 1}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
