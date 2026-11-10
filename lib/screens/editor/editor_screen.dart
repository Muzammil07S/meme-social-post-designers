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
  final _bottomController = TextEditingController(text: 'Bottom text');
  double _fontSize = 28;
  Color _textColor = Colors.white;

  @override
  void dispose() {
    _controller.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final bg = (args?['color'] as Color?) ?? Colors.deepPurple;
    final name = (args?['name'] as String?) ?? 'New Design';
    final isMeme = name.toLowerCase().contains('meme');
    final isQuote = name.toLowerCase().contains('quote');
    final isBirthday = name.toLowerCase().contains('birthday');
    final isSale = name.toLowerCase().contains('sale');

    return Scaffold(
      appBar: AppBar(title: Text('Edit: $name'), actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.preview,
              arguments: {
                'text': _controller.text,
                'bottomText': isMeme ? _bottomController.text : null,
                'size': _fontSize,
                'color': _textColor,
                'bg': bg,
                'template': name,
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
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isMeme)
                      Text(
                        _controller.text.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: _fontSize,
                          color: _textColor,
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
                            _controller.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: _fontSize, color: _textColor, fontStyle: FontStyle.italic),
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
                            _controller.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: _fontSize, color: _textColor, fontWeight: FontWeight.bold),
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
                            _controller.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: _fontSize, color: _textColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    else
                      Text(
                        _controller.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: _fontSize, color: _textColor),
                      ),

                    if (isMeme)
                      Text(
                        _bottomController.text.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: _fontSize,
                          color: _textColor,
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
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: isMeme ? 'Top Text' : 'Enter Text',
              ),
              onChanged: (_) => setState(() {}),
            ),
            if (isMeme) ...[
              const SizedBox(height: 8),
              TextField(
                controller: _bottomController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bottom Text',
                ),
                onChanged: (_) => setState(() {}),
              ),
            ],
            Slider(
              min: 14,
              max: 50,
              value: _fontSize,
              label: _fontSize.round().toString(),
              onChanged: (v) => setState(() => _fontSize = v),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Colors.white, Colors.black, Colors.yellow, Colors.cyan, Colors.pinkAccent]
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
