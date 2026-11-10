// PERSON 3: My Designs (ListView)
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';

class MyDesignsScreen extends StatefulWidget {
  const MyDesignsScreen({super.key});

  static final List<Design> designs = [
    Design(id: 1, title: 'Classic Meme', text: 'When code works on first try', bottomText: 'IT IS A MIRACLE', backgroundColorValue: Colors.orange.toARGB32(), textColorValue: Colors.white.toARGB32(), fontSize: 24),
    Design(id: 2, title: 'Birthday post', text: 'Happy Birthday to my best friend!', backgroundColorValue: Colors.pink.toARGB32(), textColorValue: Colors.white.toARGB32(), fontSize: 22),
    Design(id: 3, title: 'Quote', text: 'Keep going, success is near', backgroundColorValue: Colors.teal.toARGB32(), textColorValue: Colors.white.toARGB32(), fontSize: 22),
  ];

  @override
  State<MyDesignsScreen> createState() => _MyDesignsScreenState();
}

class _MyDesignsScreenState extends State<MyDesignsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyDesignsScreen.designs.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No saved designs yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: MyDesignsScreen.designs.length,
              itemBuilder: (context, i) {
                final d = MyDesignsScreen.designs[i];
                return GestureDetector(
                  onTap: () async {
                    await Navigator.pushNamed(context, AppRoutes.designDetail,
                        arguments: d);
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 160,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: _buildMiniPreview(d),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              d.title,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildMiniPreview(Design d) {
    final template = d.title.toLowerCase();
    final isMeme = template.contains('meme');
    final bg = Color(d.backgroundColorValue);
    final textColor = Color(d.textColorValue);

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24, width: 2),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            d.text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.bold,
              shadows: isMeme ? const [Shadow(blurRadius: 3, color: Colors.black, offset: Offset(1, 1))] : null,
            ),
          ),
          if (isMeme && d.bottomText != null && d.bottomText!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              d.bottomText!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.bold,
                shadows: const [Shadow(blurRadius: 3, color: Colors.black, offset: Offset(1, 1))],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
