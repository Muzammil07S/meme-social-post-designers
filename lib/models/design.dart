// Person 3 isko Drift table se replace/extend kar sakta hai.
class Design {
  final int id;
  final String title;
  final String text;
  final String? bottomText;
  final int backgroundColorValue;
  final int textColorValue;
  final double fontSize;

  const Design({
    required this.id,
    required this.title,
    required this.text,
    this.bottomText,
    this.backgroundColorValue = 0xFF673AB7,
    this.textColorValue = 0xFFFFFFFF,
    this.fontSize = 28.0,
  });
}
