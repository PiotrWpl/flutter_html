library flutter_html;

import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';

class Html extends StatelessWidget {
  Html({
    Key key,
    @required this.data,
    this.padding,
    this.backgroundColor,
    this.defaultTextStyle,
    this.onLinkTap,
    this.renderNewlines = false,
    this.customRender,
    this.blockSpacing = 14.0,
    this.useRichText = false,
    this.maxLines = 0,
  }) : super(key: key);

  final String data;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final TextStyle defaultTextStyle;
  final OnLinkTap onLinkTap;
  final bool renderNewlines;
  final double blockSpacing;
  final bool useRichText;
  final int maxLines;

  /// Either return a custom widget for specific node types or return null to
  /// fallback to the default rendering.
  final CustomRender customRender;

  final double LINE_OFFSET = 3.0;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    TextStyle textStyle = defaultTextStyle ?? DefaultTextStyle.of(context).style;

    return Container(
      padding: padding,
      color: backgroundColor,
      width: width,
      constraints: BoxConstraints(
        maxHeight: maxLines > 0 ? ((textStyle.fontSize + LINE_OFFSET) * maxLines + textStyle.fontSize) : double.infinity
      ),
      child: DefaultTextStyle.merge(
        style: textStyle,
        child: (useRichText)
            ? HtmlRichTextParser(
                width: width,
                onLinkTap: onLinkTap,
                renderNewlines: renderNewlines,
                html: data,
              )
            : HtmlOldParser(
                width: width,
                onLinkTap: onLinkTap,
                renderNewlines: renderNewlines,
                customRender: customRender,
                html: data,
                blockSpacing: blockSpacing,
              ),
      ),
    );
  }
}
