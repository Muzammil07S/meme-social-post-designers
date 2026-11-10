// PERSON 2: Preview / Export with Share
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';
import '../designs/my_designs_screen.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final text = (args?['text'] as String?) ?? '';
    final bottomText = args?['bottomText'] as String?;
    final size = (args?['size'] as double?) ?? 28;
    final color = (args?['color'] as Color?) ?? Colors.white;
    final bg = (args?['bg'] as Color?) ?? Colors.deepPurple;
    final template = (args?['template'] as String?) ?? '';

    final isMeme = template.toLowerCase().contains('meme');
    final isQuote = template.toLowerCase().contains('quote');
    final isBirthday = template.toLowerCase().contains('birthday');
    final isSale = template.toLowerCase().contains('sale');

    return Scaffold(
      appBar: AppBar(title: const Text('Preview & Share')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isMeme)
                      Text(
                        text.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size,
                          color: color,
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
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: size, color: color, fontStyle: FontStyle.italic),
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
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: size, color: color, fontWeight: FontWeight.bold),
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
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: size, color: color, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    else
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: size, color: color),
                      ),

                    if (isMeme && bottomText != null && bottomText.isNotEmpty)
                      Text(
                        bottomText.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size,
                          color: color,
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                    icon: const Icon(Icons.save),
                    label: const Text('Save Design'),
                    onPressed: () {
                      final newDesign = Design(
                        id: DateTime.now().millisecondsSinceEpoch,
                        title: template.isNotEmpty ? template : 'Custom Design',
                        text: text,
                        bottomText: bottomText,
                        backgroundColorValue: bg.toARGB32(),
                        textColorValue: color.toARGB32(),
                        fontSize: size,
                      );
                      MyDesignsScreen.designs.insert(0, newDesign);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Design saved to My Designs successfully!')),
                      );
                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.share, color: Colors.deepPurple),
                    label: const Text('Share', style: TextStyle(color: Colors.deepPurple)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Share Design'),
                          content: Text('Sharing text: "$text"\n\nDesign ready to share via WhatsApp / Social Media!'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
