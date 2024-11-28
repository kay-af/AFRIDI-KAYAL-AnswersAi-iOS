import "package:flutter/material.dart";

class BoldRichText extends StatefulWidget {
  final String textWithTag;
  final TextStyle defaultStyle;
  final TextStyle boldStyle;

  const BoldRichText({
    required this.textWithTag,
    required this.defaultStyle,
    required this.boldStyle,
    super.key,
  });

  @override
  State<BoldRichText> createState() => _BoldRichTextState();
}

class _BoldRichTextState extends State<BoldRichText> {
  static final _boldTagRegex = RegExp(r"(<\/?b>)");

  late Widget _child;

  @override
  void initState() {
    super.initState();
    _updateChild();
  }

  @override
  void didUpdateWidget(covariant BoldRichText oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateChild();
  }

  void _updateChild() {
    final tokens =
        widget.textWithTag.split(_boldTagRegex).where((token) => token.isNotEmpty).toList();
    bool bold = widget.textWithTag.trim().startsWith("<b>");
    final spans = <InlineSpan>[];

    int i = 0;
    while (i < tokens.length) {
      spans.add(
        TextSpan(
          text: tokens[i],
          style: bold ? widget.boldStyle : widget.defaultStyle,
        ),
      );
      bold = !bold;
      i++;
    }
    _child = Text.rich(TextSpan(children: spans));
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}
