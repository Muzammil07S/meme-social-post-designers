// PERSON 2: Editor (Stateful widget, setState)
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});
  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final _controller = TextEditingController(text: 'Your text here');
  double _fontSize = 28;
  Color _textColor = Colors.white;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final bg = (args?['color'] as Color?) ?? Colors.deepPurple;
    final name = (args?['name'] as String?) ?? 'New Design';

    return Scaffold(
      appBar: AppBar(title: Text(name), actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.preview,
              arguments: {
                'text': _controller.text,
                'size': _fontSize,
                'color': _textColor,
                'bg': bg,
              }),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: bg,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: Text(_controller.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: _fontSize, color: _textColor)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Text'),
              onChanged: (_) => setState(() {}),
            ),
            Slider(
              min: 14,
              max: 60,
              value: _fontSize,
              label: _fontSize.round().toString(),
              onChanged: (v) => setState(() => _fontSize = v),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Colors.white, Colors.black, Colors.yellow, Colors.cyan]
                  .map((c) => GestureDetector(
                        onTap: () => setState(() => _textColor = c),
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
