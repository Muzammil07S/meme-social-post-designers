// PERSON 3: Detail + delete dialog
import 'package:flutter/material.dart';
import '../../models/design.dart';

class DesignDetailScreen extends StatelessWidget {
  const DesignDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final d = ModalRoute.of(context)?.settings.arguments as Design?;
    return Scaffold(
      appBar: AppBar(title: Text(d?.title ?? 'Design'), actions: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _confirmDelete(context),
        ),
      ]),
      body: Center(
        child: Text(d?.text ?? '', style: const TextStyle(fontSize: 28)),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
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
