import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

class MapContainer extends StatelessWidget {
  const MapContainer({super.key});

  final String iframeUrl =
      "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3572.4201146227606!2d50.1114445!3d26.442183699999998!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3e49fbfd92d5cd99%3A0x8d648ab984012265!2sTrendy%20Chef!5e0!3m2!1sen!2ssa!4v1756556452198!5m2!1sen!2ssa";
  // 👉 Replace with your embed link from Google Maps

  @override
  Widget build(BuildContext context) {
    // Register a view type
    // (this only runs once per view type, so use a unique string id)
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('iframeElement', (int viewId) {
      final IFrameElement element = IFrameElement();
      element.src = iframeUrl;
      element.style.border = '0';
      element.width = '100%';
      element.height = '100%';
      return element;
    });

    return SizedBox(
      height: 250,
      width: double.infinity,
      child: HtmlElementView(viewType: 'iframeElement'),
    );
  }
}
