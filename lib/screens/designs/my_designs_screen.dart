// PERSON 3: My Designs (ListView with SQLite Database Stream & CRUD)
import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';

class MyDesignsScreen extends StatelessWidget {
  const MyDesignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Design>>(
        stream: DatabaseHelper.instance.designsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final designs = snapshot.data ?? [];

          if (designs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No saved designs in database yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: designs.length,
            itemBuilder: (context, i) {
              final d = designs[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Navigator.pushNamed(context, AppRoutes.designDetail,
                            arguments: d);
                      },
                      child: SizedBox(
                        height: 130,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            icon: const Icon(Icons.edit, size: 18),
                            label: const Text('Edit'),
                            onPressed: () async {
                              await Navigator.pushNamed(context, AppRoutes.editor, arguments: {
                                'name': d.title,
                                'color': Color(d.backgroundColorValue),
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                            label: const Text('Delete', style: TextStyle(color: Colors.red)),
                            onPressed: () async {
                              if (d.id != null) {
                                await DatabaseHelper.instance.deleteDesign(d.id!);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Design deleted from SQLite database successfully')),
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.bold,
              shadows: isMeme ? const [Shadow(blurRadius: 3, color: Colors.black, offset: Offset(1, 1))] : null,
            ),
          ),
          if (isMeme && d.bottomText != null && d.bottomText!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              d.bottomText!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
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
