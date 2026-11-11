class Design {
  final int? id;
  final String title;
  final String text;
  final String? bottomText;
  final int backgroundColorValue;
  final int textColorValue;
  final double fontSize;

  const Design({
    this.id,
    required this.title,
    required this.text,
    this.bottomText,
    this.backgroundColorValue = 0xFF673AB7,
    this.textColorValue = 0xFFFFFFFF,
    this.fontSize = 28.0,
  });

  // Convert a Design into a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'bottomText': bottomText,
      'backgroundColorValue': backgroundColorValue,
      'textColorValue': textColorValue,
      'fontSize': fontSize,
    };
  }

  // Extract a Design from a SQLite Map
  factory Design.fromMap(Map<String, dynamic> map) {
    return Design(
      id: map['id'] as int?,
      title: map['title'] as String? ?? '',
      text: map['text'] as String? ?? '',
      bottomText: map['bottomText'] as String?,
      backgroundColorValue: map['backgroundColorValue'] as int? ?? 0xFF673AB7,
      textColorValue: map['textColorValue'] as int? ?? 0xFFFFFFFF,
      fontSize: (map['fontSize'] as num?)?.toDouble() ?? 28.0,
    );
  }

  Design copyWith({
    int? id,
    String? title,
    String? text,
    String? bottomText,
    int? backgroundColorValue,
    int? textColorValue,
    double? fontSize,
  }) {
    return Design(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      bottomText: bottomText ?? this.bottomText,
      backgroundColorValue: backgroundColorValue ?? this.backgroundColorValue,
      textColorValue: textColorValue ?? this.textColorValue,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}
