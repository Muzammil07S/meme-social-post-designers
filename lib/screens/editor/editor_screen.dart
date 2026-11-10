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
    final icon = (args?['icon'] as IconData?) ?? (
      name.toLowerCase().contains('meme') ? Icons.emoji_emotions :
      name.toLowerCase().contains('quote') ? Icons.format_quote :
      name.toLowerCase().contains('birthday') ? Icons.cake :
      name.toLowerCase().contains('sale') ? Icons.local_offer :
      name.toLowerCase().contains('motivation') ? Icons.bolt : Icons.article
    );

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
                'icon': icon,
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
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Template Picture / Icon representation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, size: 36, color: Colors.white70),
                        const SizedBox(width: 8),
                        Text(name, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),

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
                          const Text('“', style: TextStyle(fontSize: 36, color: Colors.white70, height: 0.5)),
                          Text(
                            _controller.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: _fontSize, color: _textColor, fontStyle: FontStyle.italic),
                          ),
                          const Text('”', style: TextStyle(fontSize: 36, color: Colors.white70, height: 0.5)),
                        ],
                      )
                    else if (isBirthday)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _controller.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: _fontSize, color: _textColor, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text('🎉 Happy Birthday! 🎂', style: TextStyle(color: Colors.white70)),
                        ],
                      )
                    else if (isSale)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            color: Colors.yellow,
                            child: const Text('SPECIAL OFFER', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                          ),
                          const SizedBox(height: 8),
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
                      )
                    else
                      const SizedBox(height: 20), // balance spacing
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [Colors.white, Colors.black, Colors.yellow, Colors.cyan, Colors.pinkAccent]
                      .map((c) => GestureDetector(
                            onTap: () => setState(() => _textColor = c),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: c,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey)),
                            ),
                          ))
                      .toList(),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.emoji_emotions, size: 20),
                  label: const Text('Stickers'),
                  onPressed: () async {
                    final sticker = await Navigator.pushNamed(context, AppRoutes.stickers);
                    if (sticker != null && sticker is String) {
                      setState(() {
                        _controller.text = '${_controller.text} $sticker';
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
