import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/welcome/welcome_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/gallery/gallery_screen.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/editor/editor_screen.dart';
import '../screens/stickers/sticker_picker_screen.dart';
import '../screens/preview/preview_screen.dart';
import '../screens/designs/my_designs_screen.dart';
import '../screens/designs/design_detail_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/about/about_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const home = '/home';
  static const profile = '/profile';
  static const settings = '/settings';
  static const gallery = '/gallery';
  static const categories = '/categories';
  static const editor = '/editor';
  static const stickers = '/stickers';
  static const preview = '/preview';
  static const myDesigns = '/my-designs';
  static const designDetail = '/design-detail';
  static const favorites = '/favorites';
  static const search = '/search';
  static const about = '/about';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    welcome: (_) => const WelcomeScreen(),
    home: (_) => const HomeScreen(),
    profile: (_) => const ProfileScreen(),
    settings: (_) => const SettingsScreen(),
    gallery: (_) => const GalleryScreen(),
    categories: (_) => const CategoriesScreen(),
    editor: (_) => const EditorScreen(),
    stickers: (_) => const StickerPickerScreen(),
    preview: (_) => const PreviewScreen(),
    myDesigns: (_) => const MyDesignsScreen(),
    designDetail: (_) => const DesignDetailScreen(),
    favorites: (_) => const FavoritesScreen(),
    search: (_) => const SearchScreen(),
    about: (_) => const AboutScreen(),
  };
}
