// OWNER: Person 1  (Bottom Navigation + Drawer)
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../gallery/gallery_screen.dart';
import '../designs/my_designs_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final _pages = const [GalleryScreen(), MyDesignsScreen(), SettingsScreen()];
  final _titles = const ['Templates', 'My Designs', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index]), actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
        ),
      ]),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Meme / Social Post Designer',
                  style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('New Design'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.editor);
              },
            ),
            _item(context, Icons.category, 'Categories', AppRoutes.categories),
            _item(context, Icons.emoji_emotions, 'Stickers', AppRoutes.stickers),
            _item(context, Icons.favorite, 'Favorites', AppRoutes.favorites),
            _item(context, Icons.person, 'Profile', AppRoutes.profile),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.about);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _index, children: _pages),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.editor),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Templates'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'My Designs'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
