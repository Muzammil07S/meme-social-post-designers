// PERSON 3: Detail + delete dialog + favorite toggle
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../favorites/favorites_screen.dart';
import 'my_designs_screen.dart';

class DesignDetailScreen extends StatefulWidget {
  const DesignDetailScreen({super.key});

  @override
  State<DesignDetailScreen> createState() => _DesignDetailScreenState();
}

class _DesignDetailScreenState extends State<DesignDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final d = ModalRoute.of(context)?.settings.arguments as Design?;
    final isFav = FavoritesScreen.favorites.any((fav) => fav.id == d?.id);

    final template = (d?.title ?? '').toLowerCase();
    final isMeme = template.contains('meme');
    final isQuote = template.contains('quote');
    final isBirthday = template.contains('birthday');
    final isSale = template.contains('sale');
    final bg = Color(d?.backgroundColorValue ?? Colors.deepPurple.toARGB32());
    final textColor = Color(d?.textColorValue ?? Colors.white.toARGB32());
    final fontSize = d?.fontSize ?? 28.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(d?.title ?? 'Design Details'),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                if (isFav) {
                  FavoritesScreen.favorites.removeWhere((fav) => fav.id == d?.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Removed from favorites')),
                  );
                } else {
                  if (d != null) {
                    FavoritesScreen.favorites.add(d);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to favorites!')),
                    );
                  }
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmDelete(context, d),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isMeme)
                      Text(
                        (d?.text ?? '').toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(blurRadius: 4, color: Colors.black, offset: Offset(2, 2)),
                          ],
                        ),
                      )
                    else if (isQuote)
                      Column(
                        children: [
                          const Text('“', style: TextStyle(fontSize: 40, color: Colors.white70, height: 0.5)),
                          Text(
                            d?.text ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: fontSize, color: textColor, fontStyle: FontStyle.italic),
                          ),
                          const Text('”', style: TextStyle(fontSize: 40, color: Colors.white70, height: 0.5)),
                        ],
                      )
                    else if (isBirthday)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cake, size: 48, color: Colors.yellow),
                          const SizedBox(height: 8),
                          Text(
                            d?.text ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: fontSize, color: textColor, fontWeight: FontWeight.bold),
                          ),
                          const Text('🎉 Happy Birthday! 🎂', style: TextStyle(color: Colors.white70)),
                        ],
                      )
                    else if (isSale)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            color: Colors.yellow,
                            child: const Text('SPECIAL OFFER', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            d?.text ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: fontSize, color: textColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    else
                      Text(
                        d?.text ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: fontSize, color: textColor),
                      ),

                    if (isMeme && d?.bottomText != null && d!.bottomText!.isNotEmpty)
                      Text(
                        d.bottomText!.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(blurRadius: 4, color: Colors.black, offset: Offset(2, 2)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Design? d) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete design?'),
        content: const Text('Yeh design hamesha ke liye delete ho jayega.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
              if (d != null) {
                MyDesignsScreen.designs.removeWhere((item) => item.id == d.id);
                FavoritesScreen.favorites.removeWhere((item) => item.id == d.id);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Design deleted')));
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
