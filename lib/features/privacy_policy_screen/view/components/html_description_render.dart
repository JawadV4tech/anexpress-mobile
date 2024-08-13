import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_html/flutter_html.dart';

class HtmlDescriptionRender extends StatelessWidget {
  const HtmlDescriptionRender({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: HtmlWidget(
        description,
        renderMode: RenderMode.listView,
      ),
    );
  }
}
