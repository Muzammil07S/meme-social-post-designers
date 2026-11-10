import 'package:flutter/material.dart';

class StickerPickerScreen extends StatefulWidget {
  const StickerPickerScreen({super.key});

  @override
  State<StickerPickerScreen> createState() => _StickerPickerScreenState();
}

class _StickerPickerScreenState extends State<StickerPickerScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  static const Map<String, List<String>> _categories = {
    'Memes & Fun': [
      '😂', '🤣', '💀', '🗿', '🤡', '🤯', '🧐', '🤑', '🤓', '👿', '👺', '👻', '💩', '🙈', '🙉', '🙊',
      '🤪', '😜', '😈', '👀', '🤐', '🥱', '😴', '🙄', '😏', '🥶', '🥵', '😵', '😱', '🤫', '🤥', '🤮',
      '😎', '🥳', '🤠', '🥳', '😎', '😜', '🙃', '😇', '🥸', '👽', '🤖', '👾', '🎃', '👺', '👹', '👺'
    ],
    'Birthday & Party': [
      '🎉', '🎂', '🎈', '🥳', '🎁', '🍾', '🍰', '🎆', '🥂', '🧁', '🎊', '🎇', '👑', '💃', '🕺', '🎵',
      '🎶', '🍕', '🍰', '🍬', '🍭', '🍫', '🍿', '🕯️', '🪅', '🎀', '🎈', '🍾', '🍸', '🍷', '🍹', '🍺',
      '🕺', '💃', '👯‍♂️', '👯‍♀️', '🎤', '🎷', '🎸', '🎺', '🎻', '🥁', '🎟️', '🎫', '🎭', '🤹'
    ],
    'Sale & Offers': [
      '🔥', '🏷️', '💰', '⚡', '💥', '📢', '🛒', '💯', '🎁', '🎯', '🤑', '💸', '🚨', '📌', '🌟', '🛍️',
      '💵', '💶', '💷', '💳', '🔖', '📦', '🚚', '⏰', '⌛', '🔔', '📣', '‼️', '❓', '❕', '❗', '🛑',
      '📈', '💲', '🏧', '🧾', '⚖️', '🗝️', '🔐', '🏷️', '💎', '🏅', '🥇', '🥈', '🥉', '👑', '⭐'
    ],
    'Motivation': [
      '💪', '🚀', '🏆', '👑', '⚡', '🥇', '🎯', '💡', '💎', '📈', '🦁', '🔥', '👊', '🏁', '🌟', '🥊',
      '🧠', '🏔️', '🏃', '🚴', '🏋️', '🧘', '🎓', '🥇', '🥈', '🥉', '🏅', '🎖️', '⭐', '✨', '⚡', '🔮',
      '🦅', '🐺', '🧗', '🏄', '🥇', '🎗️', '🌅', '🌌', '⚡', '💥', '🔥', '☄️', '🌋', '🌊', '☀️'
    ],
    'Quotes & Love': [
      '❤️', '💖', '💕', '💗', '💓', '💞', '✨', '🌸', '🦋', '💬', '✍️', '🕊️', '📜', '🌹', '👑', '💭',
      '☀️', '🌟', '💫', '🌻', '🌺', '🌷', '🌿', '🍃', '🌊', '🌈', '🌙', '⭐', '💌', '❣', '💌', '📜',
      '🌷', '💐', '🌼', '🏵️', '💐', '🥀', '☘️', '🌾', '🌱', '☀️', '🌤️', '💫', '⚡', '🕊️', '🕊️'
    ],
    'Badges & Marks': [
      '💯', '✅', '❌', '⭕', '⚡', '🌟', '⭐', '✨', '💥', '🔥', '🎯', '🚩', '🏁', '👑', '🏆', '🥇',
      '🎖️', '🎗️', '🔮', '🧿', '🍀', '💎', '🔑', '🏷️', '📌', '📍', '⚠️', '⛔', '🚫', '🔴', '🟢', '🟡',
      '🔷', '🔶', '❇️', '✳️', '♦️', '♣️', '♠️', '♥️', '💬', '💭', '🗯️', '♠️', '♣️', '🎯'
    ],
    'Tech & Media': [
      '💻', '📱', '🎮', '🎬', '📷', '🎧', '📺', '📻', '📹', '🎥', '📼', '🔍', '⚙️', '🤖', '🔋', '🔌',
      '🖥️', '🖨️', '⌨️', '🖱️', '🖲️', '💽', '💾', '💿', '📀', '🎙️', '🎚️', '🎛️', '⏱️', '⏲️', '📡', '💡',
      '🔋', '🔌', '💻', '🕹️', '📱', '📸', '📽️', '🔭', '🔬', '🛸', '🚀', '🛰️', '⚡', '🧲'
    ],
    'Food & Drinks': [
      '🍕', '🍔', '🍟', '🌭', '🍿', '☕', '🍵', '🍦', '🍩', '🍪', '🍰', '🍫', '🍬', '🍭', '🥑', '🍎',
      '🍉', '🍓', '🍒', '🍇', '🍌', '🍍', '🥭', '🍹', '🍺', '🍻', '🥂', '🍷', '🍾', '🥤', '🧃', '🧋',
      '🥞', '🧇', '🥓', '🥩', '🍗', '🍜', '🍝', '🍣', '🍱', '🥟', '🍤', '🍙', '🍨', '🍧', '🎂'
    ],
    'Animals & Nature': [
      '🦁', '🐯', '🐻', '🐼', '🐨', '🦊', '🦅', '🐺', '🐶', '🐱', '🐴', '🦄', '🐝', '🦋', '🌸', '🌹',
      '🌴', '🌲', '🌳', '🍀', '🍁', '🍂', '🌾', '🌺', '🌻', '🌼', '🌷', '🌞', '🌙', '⭐', '🌊', '🌈',
      '🦉', '🦇', '🐬', '🦈', '🐳', '🦚', '🦜', '🦩', '🍁', '🍄', '🌍', '🌋', '🏔️', '🏖️', '🏜️'
    ],
  };

  List<String> get _allStickers {
    final List<String> list = [];
    for (var categoryList in _categories.values) {
      list.addAll(categoryList);
    }
    return list;
  }

  List<String> get _displayedStickers {
    List<String> list;
    if (_selectedCategory == 'All') {
      list = _allStickers;
    } else {
      list = _categories[_selectedCategory] ?? [];
    }

    if (_searchQuery.trim().isNotEmpty) {
      // Filter if search query exists
      final query = _searchQuery.trim();
      return list.where((s) => s.contains(query)).toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final categoryKeys = ['All', ..._categories.keys];
    final stickers = _displayedStickers;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stickers (${_allStickers.length}+)'),
      ),
      body: Column(
        children: [
          // Search box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Filter stickers...',
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),

          // Categories Chips
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categoryKeys.length,
              itemBuilder: (context, i) {
                final cat = categoryKeys[i];
                final isSelected = cat == _selectedCategory;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(cat),
                    selectedColor: Colors.deepPurple,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = cat;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Stickers Grid
          Expanded(
            child: stickers.isEmpty
                ? const Center(child: Text('No stickers found'))
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5, crossAxisSpacing: 8, mainAxisSpacing: 8),
                    itemCount: stickers.length,
                    itemBuilder: (context, i) {
                      final sticker = stickers[i];
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => Navigator.pop(context, sticker),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              sticker,
                              style: const TextStyle(fontSize: 32),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
