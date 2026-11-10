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
  Color _bgColor = Colors.teal.shade700;
  String _activeTool = 'Text'; // 'Text', 'Stickers', 'Filters', 'Background', 'Font styles'
  String _fontStyle = 'Regular'; // 'Regular', 'Bold Impact', 'Serif', 'Monospace', 'Cursive', 'Italic'
  String _activeFilter = 'Normal'; // 'Normal', 'Vintage', 'Neon', 'Sunset', 'Dark'

  bool _initialized = false;

  static const List<Color> _paletteColors = [
    Color(0xFF00897B), // Teal
    Colors.white,
    Colors.amber,
    Colors.orange,
    Colors.black,
    Colors.pink,
    Colors.purple,
    Colors.blue,
  ];

  static const List<Color> _bgColors = [
    Color(0xFF00897B), // Teal
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.green,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.redAccent,
    Colors.pink,
    Colors.purple,
    Colors.blueGrey,
    Colors.black,
    Colors.white,
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null && args.containsKey('color') && args['color'] is Color) {
        _bgColor = args['color'] as Color;
      }
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  TextStyle _getTextStyle() {
    TextStyle style = TextStyle(
      fontSize: _fontSize,
      color: _textColor,
    );

    switch (_fontStyle) {
      case 'Bold Impact':
        return style.copyWith(
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
          shadows: const [Shadow(blurRadius: 4, color: Colors.black, offset: Offset(2, 2))],
        );
      case 'Serif':
        return style.copyWith(
          fontFamily: 'serif',
          fontWeight: FontWeight.w600,
        );
      case 'Monospace':
        return style.copyWith(
          fontFamily: 'monospace',
          letterSpacing: 1.1,
        );
      case 'Cursive':
        return style.copyWith(
          fontFamily: 'cursive',
          fontStyle: FontStyle.italic,
        );
      case 'Italic':
        return style.copyWith(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        );
      case 'Regular':
      default:
        return style.copyWith(
          fontWeight: FontWeight.bold,
        );
    }
  }

  Color _getFilterOverlayColor() {
    switch (_activeFilter) {
      case 'Vintage':
        return Colors.amber.withValues(alpha: 0.25);
      case 'Neon':
        return Colors.purpleAccent.withValues(alpha: 0.25);
      case 'Sunset':
        return Colors.deepOrangeAccent.withValues(alpha: 0.3);
      case 'Dark':
        return Colors.black.withValues(alpha: 0.45);
      case 'Normal':
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
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
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: Text('Edit: $name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, size: 28),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.preview,
                arguments: {
                  'text': _controller.text,
                  'bottomText': isMeme ? _bottomController.text : null,
                  'size': _fontSize,
                  'color': _textColor,
                  'bg': _bgColor,
                  'template': name,
                  'icon': icon,
                }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Post Design Canvas Box
            Container(
              margin: const EdgeInsets.all(16),
              height: 290,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: _bgColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Filter Overlay
                  Positioned.fill(
                    child: Container(color: _getFilterOverlayColor()),
                  ),

                  // Post Content
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(icon, size: 30, color: Colors.white70),
                              const SizedBox(width: 8),
                              Text(name, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),

                          if (isMeme)
                            Text(
                              _controller.text.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: _getTextStyle(),
                            )
                          else if (isQuote)
                            Column(
                              children: [
                                const Text('“', style: TextStyle(fontSize: 32, color: Colors.white70, height: 0.5)),
                                Text(
                                  _controller.text,
                                  textAlign: TextAlign.center,
                                  style: _getTextStyle(),
                                ),
                                const Text('”', style: TextStyle(fontSize: 32, color: Colors.white70, height: 0.5)),
                              ],
                            )
                          else if (isBirthday)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _controller.text,
                                  textAlign: TextAlign.center,
                                  style: _getTextStyle(),
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
                                  style: _getTextStyle(),
                                ),
                              ],
                            )
                          else
                            Text(
                              _controller.text,
                              textAlign: TextAlign.center,
                              style: _getTextStyle(),
                            ),

                          if (isMeme)
                            Text(
                              _bottomController.text.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: _getTextStyle(),
                            )
                          else
                            const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Modern Floating Bottom Control Panel (Matching Screenshot)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Toolbar Items Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildToolTab(
                          id: 'Text',
                          label: 'Text',
                          icon: const Text('T', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF00897B))),
                        ),
                        const SizedBox(width: 8),
                        _buildToolTab(
                          id: 'Stickers',
                          label: 'Stickers',
                          iconWidget: const Icon(Icons.auto_awesome_outlined, size: 22, color: Colors.grey),
                          onTapCustom: () async {
                            final sticker = await Navigator.pushNamed(context, AppRoutes.stickers);
                            if (sticker != null && sticker is String) {
                              setState(() {
                                _controller.text = '${_controller.text} $sticker';
                              });
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        _buildToolTab(
                          id: 'Filters',
                          label: 'Filters',
                          iconWidget: const Icon(Icons.tune, size: 22, color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        _buildToolTab(
                          id: 'Background',
                          label: 'Background',
                          iconWidget: const Icon(Icons.image_outlined, size: 22, color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        _buildToolTab(
                          id: 'Font styles',
                          label: 'Font styles',
                          iconWidget: const Text('Aa', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                        ),
                        const SizedBox(width: 12),

                        // Quick Color Palette Dots on the Right
                        Row(
                          children: _paletteColors.map((c) {
                            final isSelected = _textColor.toARGB32() == c.toARGB32();
                            return GestureDetector(
                              onTap: () => setState(() => _textColor = c),
                              child: Container(
                                margin: const EdgeInsets.only(right: 6),
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: c,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFF00897B) : Colors.black12,
                                    width: isSelected ? 2.5 : 1,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Dynamic Control Section for Selected Tool
                  _buildActiveToolControls(isMeme),

                  const SizedBox(height: 16),

                  // Big Action Button: "+ Add Caption"
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00897B), // Teal theme from screenshot
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.add, size: 22),
                      label: const Text(
                        'Add Caption',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        setState(() {
                          _activeTool = 'Text';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Type your caption in the text box!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolTab({
    required String id,
    required String label,
    Widget? icon,
    Widget? iconWidget,
    VoidCallback? onTapCustom,
  }) {
    final isSelected = _activeTool == id;
    return GestureDetector(
      onTap: onTapCustom ?? () => setState(() => _activeTool = id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE0F2F1) : Colors.transparent, // Light Teal highlight
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            iconWidget ?? (icon ?? const SizedBox()),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF00897B) : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveToolControls(bool isMeme) {
    switch (_activeTool) {
      case 'Background':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Background Color:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _bgColors.map((c) {
                  final isSelected = _bgColor.toARGB32() == c.toARGB32();
                  return GestureDetector(
                    onTap: () => setState(() => _bgColor = c),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? const Color(0xFF00897B) : Colors.black12,
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 18) : null,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );

      case 'Filters':
        final filters = ['Normal', 'Vintage', 'Neon', 'Sunset', 'Dark'];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Photo Filters & Style:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filters.map((f) {
                  final isSelected = _activeFilter == f;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      selected: isSelected,
                      label: Text(f),
                      selectedColor: const Color(0xFF00897B),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (_) => setState(() => _activeFilter = f),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );

      case 'Font styles':
        final styles = ['Regular', 'Bold Impact', 'Serif', 'Monospace', 'Cursive', 'Italic'];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Font Style:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: styles.map((s) {
                  final isSelected = _fontStyle == s;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      selected: isSelected,
                      label: Text(s),
                      selectedColor: const Color(0xFF00897B),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (_) => setState(() => _fontStyle = s),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );

      case 'Text':
      default:
        return Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                labelText: isMeme ? 'Top Text' : 'Enter Text',
              ),
              onChanged: (_) => setState(() {}),
            ),
            if (isMeme) ...[
              const SizedBox(height: 8),
              TextField(
                controller: _bottomController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  labelText: 'Bottom Text',
                ),
                onChanged: (_) => setState(() {}),
              ),
            ],
            const SizedBox(height: 6),
            Row(
              children: [
                const Text('Size: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Expanded(
                  child: Slider(
                    activeColor: const Color(0xFF00897B),
                    min: 14,
                    max: 50,
                    value: _fontSize,
                    label: _fontSize.round().toString(),
                    onChanged: (v) => setState(() => _fontSize = v),
                  ),
                ),
              ],
            ),
          ],
        );
    }
  }
}
