// PERSON 3: My Designs (ListView)
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';

class MyDesignsScreen extends StatefulWidget {
  const MyDesignsScreen({super.key});

  static final List<Design> designs = [
    const Design(id: 1, title: 'Classic Meme', text: 'When code works on first try'),
    const Design(id: 2, title: 'Birthday post', text: 'Happy Birthday! 🎉'),
    const Design(id: 3, title: 'Quote', text: 'Keep going, success is near'),
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
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple.shade700, Colors.indigo.shade500],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () async {
                        await Navigator.pushNamed(context, AppRoutes.designDetail,
                            arguments: d);
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    d.title,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white70),
                              ],
                            ),
                            Text(
                              d.text,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
