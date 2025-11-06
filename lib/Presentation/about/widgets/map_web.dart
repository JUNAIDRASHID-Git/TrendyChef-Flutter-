// // ignore: avoid_web_libraries_in_flutter
// import 'dart:ui' as ui;
// import 'package:universal_html/html.dart' as html;

// void registerIFrame(String viewId, String url) {
//   // register iframe factory for Web
//   // ignore: undefined_prefixed_name
//   ui.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
//     final html.IFrameElement element = html.IFrameElement();
//     element.src = url;
//     element.style.border = '0';
//     element.width = '100%';
//     element.height = '100%';
//     return element;
//   });
// }
