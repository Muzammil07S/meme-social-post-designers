// PERSON 2: Template Categories (TabBar + TabController)
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static final Map<String, Map<String, dynamic>> _tabsData = {
    'Memes': {
      'color': Colors.orange,
      'icon': Icons.emoji_emotions,
      'items': ['Classic Meme', 'Dank Meme', 'Tech Meme', 'Office Meme', 'Gaming Meme', 'School Meme']
    },
    'Quotes': {
      'color': Colors.teal,
      'icon': Icons.format_quote,
      'items': ['Life Quote', 'Success Quote', 'Wisdom', 'Friendship', 'Mindset', 'Inspiration']
    },
    'Birthday': {
      'color': Colors.pink,
      'icon': Icons.cake,
      'items': ['Happy Bday', 'Party Time', 'Cake & Candles', 'Best Wishes', 'Celebration', 'Cheers']
    },
    'Motivation': {
      'color': Colors.indigo,
      'icon': Icons.bolt,
      'items': ['Keep Going', 'No Excuses', 'Hustle', 'Rise & Grind', 'Focus', 'Believe']
    },
    'Sale': {
      'color': Colors.redAccent,
      'icon': Icons.local_offer,
      'items': ['Flash Sale', 'Big Discount', 'Special Offer', 'Clearance', 'New Arrival', 'Limited Deal']
    },
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabsData.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories & Templates'),
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabsData.keys.map((k) => Tab(
              icon: Icon(_tabsData[k]!['icon'] as IconData),
              text: k,
            )).toList(),
          ),
        ),
        body: TabBarView(
          children: _tabsData.entries.map((entry) {
            final data = entry.value;
            final color = data['color'] as Color;
            final items = data['items'] as List<String>;

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.1),
              itemCount: items.length,
              itemBuilder: (context, i) {
                final templateName = items[i];
                return InkWell(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.editor,
                      arguments: {'name': templateName, 'color': color}),
                  child: Card(
                    color: color,
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(data['icon'] as IconData, size: 36, color: Colors.white),
                          const SizedBox(height: 8),
                          Text(
                            templateName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
